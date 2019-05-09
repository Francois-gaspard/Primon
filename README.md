# README

## What is this?

Primon (Price-Monitor) is a small app that tracks online prices for items of your choice on various (thai) shops. At this time, it supports:
- Powerbuy
- Homepro
- BigC
- Boonthavorn
- PantipMarket
- Robinson

It's a single-user app (that could be changed, but I have no use for multi-user support) running mostly on ActiveAdmin.

It's rough, it was coded in a short time to get something up and running, with nearly no thoughts put into maintainability. However, I'm happy with how it works.

## Setup

### Deployment

I've made it to be easy to deploy on Heroku with minimal setup. Open the following link, give a name to your app and deploy it.
[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)

## Creating a user
User creation is done from the console:
```
User.create(email: "put your email here", password: "put your password here")
```
You can access the console directly after deployment by clicking the "Manage app" button and then going to the "More" menu:
![Run Console](https://devcenter0.assets.heroku.com/article-images/1493674728-Screen-Shot-2017-05-01-at-11.21.27-AM.png)
https://devcenter.heroku.com/articles/heroku-dashboard#application-overview


## How does it work?

### Products
 First, create a product. E.g.: `Toshisung Fridge/toothpaste dispenser combo` and


The app can be deployedThis README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...
