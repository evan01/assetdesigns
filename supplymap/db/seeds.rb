# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
#
# First do the supply chains
Supply_Chain_List = [
    [ "Canada Chain", "Canada eh. We've got 3 suppliers that all come from across the best country ever" ],
    [ "France Chain", "Cette chaine est entirement Francaise" ],
    [ "China Chain", "这条供应链完全是法国的" ],
    [ "USA Chain", "Howdy partner! This here supply chain is mighty fine and dandy" ]
]

Supply_Chain_List.each do |name, description|
  SupplyChain.create( name: name, description: description )
end

Suppliers_List = [
    ["Lanister", "Shirts", "Always pay your debts", 1, -77.03, 38.895, 1],
    ["Stark", "hoodies", "Winter is coming",2, 23.4,-20.4, 1],
    ["Targarian", "jackets", "Our queen is 10/10 better than your queen", 3, 15.4, 5.90, 1],
    ["Tyrell", "bags", "Margaery noooooooooo </3", 2, 4.42, 10.3, 2],
    ["Baratheon", "hunting equipment", "Invade! Oh... ok maybe not", 1, -78.3, 56.4223, 3],
    ["Greyjoy", "Bathing Suits", "Just keep swimming", 1, -77.03, 38.895, 2],
]

Suppliers_List.each do |name, type, description, supply_chain_id, lattitude, longitude, order|
  Supplier.create( name:name, product_kind:type, description:description, supply_chain_id:supply_chain_id, lattitude:lattitude, longitude:longitude, order:order)
end

Supplier_Connection_List = [
    [1, 2, 50, 11830],
    [1, 3, 40, 3434],
    [2, 3, 5, 10],
    [3, 4, 100, 433020],
    [4, 5, 40, 32123],
    [5, 6, 32, 3243241]

]
Supplier_Connection_List.each do |supplier_a_id, supplier_b_id, co2_emission, distance|
 SupplierConnection.create(supplier_a_id:supplier_a_id, supplier_b_id:supplier_b_id, co2_emission:co2_emission, distance:distance)
end
