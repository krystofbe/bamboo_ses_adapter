# Bamboo SES Adapter

Amazon Simple Email Service (Amazon SES) is a cloud-based email sending service designed to help digital marketers and application developers send marketing, notification, and transactional emails. It is a reliable, cost-effective service for businesses of all sizes that use email to keep in contact with their customers.

You can use `bamboo_ses_adapter` to integrate Amazon SES directly into your elixir applications.

## Installation

The package can be installed as:

1. Add exiban to your list of dependencies in `mix.exs`:


    ```elixir
    def deps do
      [{:bamboo_ses_adapter, "~> 0.0.1"}]
    end
    ```

2. Run `mix deps.get` in your console to fetch from Hex

## Documentation

Hosted on [http://hexdocs.pm/bamboo_ses_adapter/readme.html](http://hexdocs.pm/bamboo_ses_adapter/readme.html)

## Configuration

Change the config for your mailer:

    config :my_app, MyApp.Mailer,
      adapter: Bamboo.AwsSesAdapter

To find more on AWS key configuration please follow [this link](https://github.com/ex-aws/ex_aws#aws-key-configuration)

## Author

Krystof Beuermann

bamboo_ses_adapter is released under the [MIT License](https://github.com/appcues/exsentry/blob/master/LICENSE.txt).

it's very much inspired by `Hexpm.Emails.Bamboo.SESAdapter` from https://github.com/hexpm/hexpm and kalys' bamboo_ses
https://github.com/kalys/bamboo_ses
