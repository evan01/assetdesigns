# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)


SupplyChain.create([
    {
        :name => 'Ottawa',
        :description => 'This is the Ottawa supply chain description',
    },
    {
        :name => 'Toronto',
        :description => 'This is the Toronto supply chain description',
    },
    {
        :name => 'Montreal',
        :description => 'This is the Montreal supply chain description',
    },
])

Connection.create([
    {
        :order_in_chain => 0,
        :supplier_connected_to => 1,
        :co2_emission => 100,
        :transportation => "truck",
        :supply_chain_id => 1
    },
    {
        :order_in_chain => 1,
        :supplier_connected_to => 2,
        :co2_emission => 200,
        :transportation => "plane",
        :supply_chain_id => 1
    },
    {
        :order_in_chain => 2,
        :supplier_connected_to => 3,
        :co2_emission => 300,
        :transportation => "car",
        :supply_chain_id => 1
    }
])

Supplier.create([
    {
        :name => "Lanister",
        :description => "Always pays his debts",
        :image_url => "/images/lanister.png"
    },
    {
        :name => "Stark",
        :description => "Winter is coming",
        :image_url => "/images/stark.png"
    },
    {
        :name => "Tyrell",
        :description => "Margaery nooooooo",
        :image_url => "/images/Tyrell.png"
    },
])