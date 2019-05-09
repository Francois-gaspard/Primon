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

It's rough, it was coded in a short time to get something up and running, with nearly no thoughts put into maintainability. However, I'm happy with how it works despite some minor bugs.

## Setup

### Deployment

It's meant to be easy to deploy on Heroku with minimal setup. 
Open the following link, give a name to your app and deploy it.

[![Deploy](https://www.herokucdn.com/deploy/button.svg)](https://heroku.com/deploy)



After deployment, you can sign up 1 user from the registration page. Further sign ups will be rejected, as Primon doesn't support
more than one user.

### Scheduler
The app relies on Heroku Scheduler to fetch prices at regular intervals. 
That must be setup from your Heroku Dashboard ( https://dashboard.heroku.com/apps )
Select your app in the list, then click on `Heroku Scheduler`:

<img width="614" alt="Screen Shot 2019-05-09 at 17 57 02" src="https://user-images.githubusercontent.com/16531233/57448590-f2205c00-7283-11e9-98ae-808639736057.png">

Then create a job that runs the command `rails scraper:run` `every hour` at `:00`

If you want more data resolution, you can duplicate that job at `:30`, which will increase the polling rate from every hour to every 30 min.

That's it.


## How does it work?

TL;DR: You create `products` and assign them one or more `monitored urls` (product pages on online shops). The app scrapes prices from those pages and generates `scraping results` to create a price history.
If a price is the lowest it has ever been, the app sends a notification by email.

### Products
 If you're interested in a specific product (e.g. "Toshisung's 57.5 inch LED toaster"), find that product page on supported websites (listed above).
 
 Sign in and create a new product. Enter its name and copy the product URLs into the corresponding fields.
 
 Save. Then come back later and see the price data for your product.

A chart comparing the price of a product at different shops over time:

<img width="1192" alt="Screen Shot 2019-05-09 at 13 59 20" src="https://user-images.githubusercontent.com/16531233/57449460-2ac13500-7286-11e9-8b73-7bda0a6c1723.png">
 
 
 You can also see the discount evolution of a product at a given shop, over time.
 Blue represents the discounted price. Red represents the discount. The sum of both is the regular price.
 
 <img width="1177" alt="Screen Shot 2019-05-09 at 13 59 44" src="https://user-images.githubusercontent.com/16531233/57449839-20ec0180-7287-11e9-8e51-728588458431.png">

  
