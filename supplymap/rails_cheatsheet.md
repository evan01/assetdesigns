# Setup of Rails App
    git fetch | git pull
Will get the latest code from our repols

    bundle install
Installs external libraries onto your computer that the rails app, (runnning on your computer) will need.

    rake db:setup
    rake db:migrate
Creates a database on your computer! Adds (the latest tables and columns data) to your database

    rails s
Starts the rails server on port 3000 by default

# If you want to see development changes on Shopify
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
    

# Rails Commands
Whenever you want to do or change **ANYTHING**  with the application, you can run a rails command to generate the changes that you want.
    rails -Command

#### Create an API function
    rails generate controller CONTROLLER_NAME
    https://www.tutorialspoint.com/ruby-on-rails/rails-controllers.htm

#### Add  Column to Table https://stackoverflow.com/questions/12984316/rails-database-add-column

#### Add a new Table
`rails g migration Create<TableName> <col1>:type <col2>:type ...ect`
    
# Active record commands
    rails c //Puts you in the rails console where you can run the commands below
list all tables - `ActiveRecord::Base.connection.tables`

