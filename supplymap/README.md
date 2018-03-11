# README

This is the readme file for the supplyMap, ruby on rails application.

* Ruby version
2.4.1


# Configuration
We have a rails application running, either on a heroku webserver (for production), or locally on your laptop for development.

heroku --> https://asset-designs-supply-chain.herokuapp.com/login
local --> http://localhost:3000
### Setup of Rails App Locally
    git fetch | git pull
Will get the latest code from our repo

    bundle install
Installs external libraries onto your computer that the rails app, (runnning on your computer) will need.

    rake db:setup
    rake db:migrate
Creates a database on your computer! Adds (the latest tables and columns data) to your database. If these commands fail, you may need to [install postgres](https://www.postgresql.org/download/) - the DBMS used in this project.

    rails s 
Starts rails server on port 3000

## Configure Shopify to Access Local Server
Shopify can't access your locally running rails app unless you make it available over the internet. `Ngrok` is a program that does this. Assuming the ngrok program is in your main app directory...

    ./ngrok http 3000


Tells ngrok to map all traffic from its soon to be public ip address to this port on your computer. It will give you details about about the public link that shopify can see via http and https.

#### Shopify needs to be told that the app you've installed on your store, will be sending requests to the ngrok url you just discovered.
After loggin into your develoment account in Shopify.
Go to

    Apps >> rails_supplyChainMap >> AppInfo

Go ahead and change the App Url and whitelisted url to point to your ngrok public url

App URL = https://226351be.ngrok.io/ 

whitelisted url= https://226351be.ngrok.io/auth/shopify/callback

I believe our app is already configured in github with the propper api key but I could be wrong..
    

# About Ruby on Rails
Ruby on Rails is the framework that powers the application we're building. **When you want to add a feature to the application, you will need to run a `rails` command on the command line. Running a rails command will create the nescessary files/ code to do the things you want!**


## How to Work with the API

### Add an API Endpoint
An endpoint is just a url where you can request data from our application. When you make a request (any request), to our application, the request gets sent to `routes.rb`. This file acts like a mailman, that looks at the request and sends the request to the correct **controller**. Controllers are responsible for taking requests and then getting the data that's requested.

Running `rails generate controller SupplyChain` will create a controller called SupplyChain for you, **but will not change the routes.rb** file. This means that unless you modify routes.rb, nothing is going to happen.
To create a mapping from  in the **routes.rb** file, we have to map a request(leftside) to a controller(rightside).


	//routes.rb 
	get 'supply_chain/' => 'supply_chain#test'
	get 'supply_chain/all_shops' => 'supply_chain#all_shops'

These mappings are great, but we also need our controller to do things/get data from our database when it receives the request. Here's where we modify the supply_chain_controller (in ruby, the controller names are **different** from the name you thought was generated).

	class SupplyChainController < ApplicationController
	    def test 
	        p "API request for supply chain!"
	        shops = SupplyChain.all
	        render json: {status: 'SUCCESS', message: 'Loaded all shops', data: shops}, status: :ok //Json to send back
	    end 
	    def all_shops
	        p "Requesting all shops"
	        shops = Shop.all
	        render json: {status: 'SUCCESS', message: 'Loaded all shops', data: shops}, status: :ok //Json to send back.
	    end 
	end

Btw, **in ruby, the last line of the method is the thing being returned**

Now that we've added our endpoint, it's time to start our server and test it! There's different ways of testing api requests, but my favorite is to use an app called [Postman](https://www.getpostman.com/) .Don't forget to start your rails server, `rails s`.

####Setting up Postman
First [Get Postman](https://www.getpostman.com/) 
Sign in as 

	username: jamesmcgill
	password: <OUR PASSWORD ON SLACK>

You should be able to see a supplychain collection with a request already set up... if not. 

1. Create a collection
2. Create a GET request
3. Run `rails s` /make sure your local rails app is running
4. Send the request to `http://localhost:3000/supply_chain`

And you should see the following!

        {
            "status":"SUCCESS",
            "message":"Loaded all shops",
            "data":[
                {
                    "id":1,
                    "shopify_domain":"assetdesignsdev.myshopify.com",
                    "shopify_token":"86cf15304967492f4f78338f7cb97e0a",
                    "created_at":"2018-03-01T17:57:48.137Z",
                    "updated_at":"2018-03-01T17:57:48.137Z"
                }
            ]
        }

TADA! Any web app can now access our api, and get the json data it needs.


## Database Changes/Commands
To do database modifications, you (as per usual), need to run some rails commands, that write autocode for the changes you want to make, and then run some **rake** commands, to run autogenerated rails files and change your local database.

#### Add  Column to Table https://stackoverflow.com/questions/12984316/rails-database-add-column

#### Add a new Table
`rails g migration Create<TableName> <col1>:type <col2>:type ...ect`
    
# Active record commands
list all tables - `ActiveRecord::Base.connection.tables`

# Admin side API
Since the admin really only needs to modify suppliers and supply_chains, there are two url trees that can be accessed.
The first is applicationpath/suppliers/ which lists all current suppliers in the databse. The adin is able to create and modify each existing supplier.
The specific paths to do so are applicationpath/suppliers/new and applicationpath/suppliers/supplier_id/edit
The path applicationpath/suppliers/supplier_id/show can also be used to view one supplier at a time.

Example path: localhost:3000/suppliers/4/edit, this will bring up a page to modify the supplier with id 4.

The same architecture (i.e.: the show and edit pages) is set up for the supply chains with the path applicationpath/supply_chains/*

# Client side API
The rails program also supports a different set of urls to be used by the client side map application (or whatever you want to call it).
The urls are used to get JSON formatted data about the shops, products, suppliers and supply_chains and are respectively located at the creatively named:
* applicationpath/all_shops
* applicationpath/all_products
* applicationpath/all_suppliers
* applicationpath/all_supply_chains

For example:
request the page at localhost:3000/all_suppliers will return the JSON formatted data of all suppliers in the database.

# Readme Todo
* How to run the test suite
* Deployment instructions
