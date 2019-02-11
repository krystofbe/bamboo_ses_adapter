defmodule Bamboo.AwsSesAdapter do
  @moduledoc """
  Sends email using AWS SES API.
  Use this adapter to send emails through AWS SES API.

  All recipients in the Bamboo.Email struct will be normalized to a 2 item tuple
  of {name, address} when deliver through your mailer. For example,
  `email.from |> elem(0)` would return the name and `email.from |> elem(1)`
  would return the email address.

  For more in-depth examples check out the
  [adapters in Bamboo](https://github.com/paulcsmith/bamboo/tree/master/lib/bamboo/adapters).
  ## Example
      defmodule Bamboo.CustomAdapter do
        @behaviour Bamboo.Adapter
        def deliver(email, config) do
          deliver_the_email_somehow(email)
        end
        def handle_config(config) do
          # Return the config if nothing special is required
          config
          # Or you could require certain config options
          if Map.get(config, :smtp_username) do
            config
          else
            raise "smtp_username is required in config"
          end
        end
      end
  """
  require Logger

  @behaviour Bamboo.Adapter
  @backoff 100
  @backoff_times 5

  def deliver(email, _config) do
    if email.headers != %{} do
      raise "headers not supported for Bamboo.AwsSesAdapter"
    end

    destination = %{
      to: emails(email.to),
      cc: emails(email.cc),
      bcc: emails(email.bcc)
    }

    message = ExAws.SES.build_message(email.html_body, email.text_body, email.subject)

    request = ExAws.SES.send_email(destination, message, email(email.from), [])
    send_email(request, email, 0)
  end

  def handle_config(config) do
    config
  end

  defp send_email(request, email, times) do
    request
    |> ExAws.request()
    |> maybe_retry(request, email, times)
  end

  defp maybe_retry({:error, {:http_error, 454, _body}} = error, request, email, times) do
    if times > @backoff_times do
      Logger.warn("AWS SES throttled ##{times}")
      raise "Failed to send email\n\n#{inspect(email)}\n\n#{inspect(error)}"
    else
      Process.sleep(@backoff * trunc(:math.pow(2, times)))
      send_email(request, email, times + 1)
    end
  end

  defp maybe_retry({:error, _} = error, _request, email, _times) do
    raise "Failed to send email\n\n#{inspect(email)}\n\n#{inspect(error)}"
  end

  defp maybe_retry({:ok, result}, _request, _email, _times) do
    result
  end

  defp emails(emails), do: emails |> List.wrap() |> Enum.map(&email/1)

  defp email({name, email}), do: "#{name} <#{email}>"
  defp email(email), do: email
end
