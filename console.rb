require_relative('models/bounty')


bounty1 = Bounty.new(
  {
    'name'=> 'Zargas',
    'species'=> 'Grup',
    'bounty'=> '45',
    'favourite_weapon'=> 'Zapper'
  }
)

bounty2 = Bounty.new(
  {
    'name'=> 'Zaphod Beeblebrox',
    'species'=> 'Undefined',
    'bounty'=> '42',
    'favourite_weapon'=> 'Heart of Gold'
  }
)

bounty1.save
bounty2.save
bounty1.favourite_weapon = 'balloon'
bounty1.bounty = 200
bounty1.update
bounty1.delete

p Bounty.find(4)


# p Bounty.all

nil
