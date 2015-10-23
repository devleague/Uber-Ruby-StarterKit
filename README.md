# Uber Ruby StarterKit

Uber Hackathon Starter Kit for Ruby

The sample code makes calls to the [sandbox api](https://developer.uber.com/v1/sandbox/) endpoints at https://sandbox-api.uber.com/v1/

The sandbox url should be used for development.

The production api url is https://api.uber.com/v1/

## Requirements

- have an uber account
- create an app at https://developer.uber.com
- clone this project, all commands are issued from inside this project directory
- have ruby installed (tested with ruby 2.2.3p173)

### Environment Variables

You should never commit your secret/private information to your scm.

Each script requires environment variables to be set in a file named `.env`

copy `.env-sample` to `.env` and follow the template to add your uber api keys

example

```
UBER_SERVER_TOKEN="YOUR-SECRET-KEY-HERE"
UBER_CLIENT_ID="YOUR-SECRET-KEY-HERE"
UBER_CLIENT_SECRET="YOUR-SECRET-KEY-HERE"
```

this information can be found from your uber developer console by editing an app that you have created. https://developer.uber.com/dashboard

scripts will be run by reading the `.env` file. the env variables are set during when running a script per _session_, that is, the environment variables will not persist.

this is done by running `env $(cat .env | xargs) ...your command`

if you do not have the `xargs` program (it is installed in osx and ubuntu linux by default), then you can install it for your operating system.

or, set each environment variable manually without `.env`

example

```
UBER_SERVER_TOKEN=your-uber-server-token \
UBER_CLIENT_ID=your-uber-client-id \
UBER_CLIENT_SECRET=your-cient-secret \
...your command
```

## Problems?

if you are seeing errors, make sure that there is a `.env` file located in the current directory which should be the project root, and that it is in the same format as `.env-sample` and that it has valid secret keys and tokens from the uber developer api.

## Simple requests

The Uber API has 3 routes that only require server side authentication, and do not require a user to authorize via OAuth2

```
GET /v1/products
GET /v1/estimates/time
GET /v1/estimates/price
```

### Products

**GET /v1/products**

https://developer.uber.com/v1/endpoints/#product-types

run the `simple_products.rb` script

`env $(cat .env | xargs) ruby simple_products.rb`

result __(truncated)__

```
{
  "products": [
    {
      "capacity": 4,
      "product_id": "6e731b60-2994-4f68-b586-74c077573bbd",
      "price_details": {
        "service_fees": [
          {
            "fee": 1.05,
            "name": "Safe rides fee"
          }
        ],
        "cost_per_minute": 0.3,
        "distance_unit": "mile",
        "minimum": 4.05,
        "cost_per_distance": 1.4,
        "base": 2.15,
        "cancellation_fee": 5.0,
        "currency_code": "USD"
      },
      "image": "http://d1a3f4spazzrp4.cloudfront.net/car-types/mono/mono-uberx.png",
      "display_name": "uberX",
      "description": "the low-cost uber"
    },
    {
      "capacity": 6,
      "product_id": "2d2af87b-b870-4286-a300-7e7a8a79cd8c",
      "price_details": {
        "service_fees": [
          {
            "fee": 1.05,
            "name": "Safe rides fee"
          }
        ],
        "cost_per_minute": 0.35,
        "distance_unit": "mile",
        "minimum": 7.05,
        "cost_per_distance": 2.8,
        "base": 3.85,
        "cancellation_fee": 5.0,
        "currency_code": "USD"
      },
      "image": "http://d1a3f4spazzrp4.cloudfront.net/car-types/mono/mono-uberxl2.png",
      "display_name": "uberXL",
      "description": "low-cost rides for large groups"
    },
...
```


### Price Estimate

**GET /v1/estimates/price**

https://developer.uber.com/v1/endpoints/#price-estimates

run the `simple_price_estimates.rb` script

`env $(cat .env | xargs) ruby simple_price_estimates.rb`

result _(truncated)_

```
{
  "prices": [
    {
      "localized_display_name": "uberX",
      "high_estimate": 15,
      "minimum": 4,
      "duration": 791,
      "estimate": "$11-15",
      "distance": 3.81,
      "display_name": "uberX",
      "product_id": "6e731b60-2994-4f68-b586-74c077573bbd",
      "low_estimate": 11,
      "surge_multiplier": 1.0,
      "currency_code": "USD"
    },
    {
      "localized_display_name": "uberXL",
      "high_estimate": 24,
      "minimum": 7,
      "duration": 791,
      "estimate": "$18-24",
      "distance": 3.81,
      "display_name": "uberXL",
      "product_id": "2d2af87b-b870-4286-a300-7e7a8a79cd8c",
      "low_estimate": 18,
      "surge_multiplier": 1.0,
      "currency_code": "USD"
    },
...
```


### Time Estimate

**GET /v1/estimates/time**

https://developer.uber.com/v1/endpoints/#time-estimates

run the `simple_time_estimates.rb` script

`env $(cat .env | xargs) ruby simple_time_estimates.rb`

result _(truncated)_

```
{
  "times": [
    {
      "localized_display_name": "uberX",
      "estimate": 669,
      "display_name": "uberX",
      "product_id": "6e731b60-2994-4f68-b586-74c077573bbd"
    },
    {
      "localized_display_name": "UberBLACK",
      "estimate": 882,
      "display_name": "UberBLACK",
      "product_id": "18c45a2d-a7bc-44b3-900d-ccf1f6b77729"
    },
...
```


## OAuth2 Requests

*Requirements*

- set your uber app redirect url in the [uber developer dashboard](https://developer.uber.com/dashboard)
    - example: `http://localhost:8080/auth/uber/callback`
- have rails installed (tested with rails 4.2.4)
- install all dependencies using `bundle install`
- run the rails servr with on port `8080`
    - `env $(cat .env | xargs) rails server -b 0.0.0.0 -p 8080`

_when developing your app with [omniauth](https://github.com/tmilewski/omniauth-uber)_

add this to your `Gemfile`
```
gem 'omniauth-uber'
```

then `bundle install`


### Configuration

all configuration for authorizing with the uber api is in your `.env` file.

[OmniAuth](https://github.com/tmilewski/omniauth-uber) reads the environment variables in `config/initializers/omniauth.rb`

you must start the server with `env $(cat .env | xargs) rails server -b 0.0.0.0 -p 8080`


### Authorizing

visit the oauth2_server app in your browser, go to http://localhost:8080/auth/uber

this route will redirect you to uber to login

once you are authenticated with uber, and authorize the scopes requested, you will be redirected to the callback url http://localhost:8080/auth/uber/callback

the authorized user information will be displayed on the `sessions#create` route, normally you would get or create the user using the information available in `request.env['omniauth.auth']` and then redirect the user back to your app.

note the `credentials.token`

example result on successful authorization
_(truncated)_

```
{
  "provider": "uber",
  "uid": "5c768f51-9763-4d17-a9bd-2168f4a87722",
  "info": {
    "first_name": "John",
    "last_name": "Doe",
    "email": "uber@devleague.com",
    "picture": "https://d1w2poirtb3as9.cloudfront.net/default.jpeg",
    "promo_code": "xdevleague",
    "name": "John Doe"
  },
  "credentials": {
    "token": "SaMbnvDYqNt0rmmYUo8jLNhjR0rOK5",
    "refresh_token": "3Y13o1wMNsRAUFUesEy92ozBUPhfgs",
    "expires_at": 1448174362,
    "expires": true
  },
...
```

the token is `SaMbnvDYqNt0rmmYUo8jLNhjR0rOK5`

this user can now make authorized requests to the uber api

test this manually by visiting http://localhost:8080/profile?access_token=[your token here]

example

```
http://localhost:8080/profile?access_token=rgHxpYJABmBmiiG0DBOXvgoKyVY10v
```

response

```
{
  "picture":"https:\/\/d1w2poirtb3as9.cloudfront.net\/default.jpeg",
  "first_name":"Jonh",
  "last_name":"Doe",
  "promo_code":"xdemo",
  "email":"uber@devleague.com",
  "uuid":"5c768f51-9763-4d17-a9bd-2168f4a8772b"
}
```

review the following files relevant to setting up your rails app with oauth and uber

- [.env](.env)
- [Gemfile](Gemfile)
- [config/routes.rb](config/routes.rb)
- [config/initializers/omniauth.rb](config/initializers/omniauth.rb)
- [app/controllers/sessions_controller.rb](app/controllers/sessions_controller.rb)
- [app/controllers/application_controller.rb](app/controllers/application_controller.rb)





