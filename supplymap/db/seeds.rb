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
    ["Lanister", "Shirts", "Always pay your debts", -77.03, 38.895, 1, [1,3]],
    ["Stark", "hoodies", "Winter is coming", 23.4,-20.4, 1],
    ["Targarian", "jackets", "Our queen is 10/10 better than your queen", 15.4, 5.90, 1, [2]],
    ["Tyrell", "bags", "Margaery noooooooooo </3", 4.42, 10.3, 2, [3,4]],
    ["Baratheon", "hunting equipment", "Invade! Oh... ok maybe not", -78.3, 56.4223, 3, [1]],
    ["Greyjoy", "Bathing Suits", "Just keep swimming", -77.03, 38.895, 2, [1]],
]

Suppliers_List.each do |name, type, description, lattitude, longitude, order, supply_chain_ids|
  Supplier.create( name:name, product_kind:type, description:description, lattitude:lattitude, longitude:longitude, order:order, supply_chain_ids:supply_chain_ids)
end

Supplier_Connection_List = [
    [1, 1, 5, 50, 11830],
    [1, 5, 6, 40, 3434],
    [3, 1, 4, 5, 10],
]
Supplier_Connection_List.each do |supply_chain_id, supplier_a_id, supplier_b_id, co2_emission, distance|
 SupplierConnection.create(supply_chain_id:supply_chain_id, supplier_a_id:supplier_a_id, supplier_b_id:supplier_b_id, co2_emission:co2_emission, distance:distance)
end
