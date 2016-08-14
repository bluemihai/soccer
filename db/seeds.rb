years = (1995..2016)

years.each do |year|
  Season.create!(id: year)
  Season.last.update(start: Date.new(2016, 9, 11))
end

divisions = {
  a: [
    'Africari Deep Roots',
    'Berkeley Fog',
    'Berkeley Juniors',
    'IFC Ajax',
    'Oakland Defiant',
    'Rovers',
    'Sporting Club',
    'Walnut Creek Unite'
  ],
  b: [
    'AFC Juventus',
    'Alameda Celtics',
    'American International',
    'FC United',
    'IFC East Bay United',
    'International',
    'Starry Plough',
    'The Crow'    
  ],
  c: [
    'Africari United',
    'Alameda Athletic',
    'Arsenal',
    'Clayton Town',
    'Europe FC',
    'Mt Diablo SC',
    'San Pablo United',
    'Olympic'
  ],
  d: [
    'AFC Real',
    'AFC Roma',
    'Africari Big Time',
    'Alameda Islanders',
    'Berkeley Old Boys ',
    'Orinda SC',
    'Polonez',
    'Walnut Creek 40+' 
  ],
  e: [
    'Alameda Old Boys',
    'Azzurri',
    'Bohemians FC',
    'Celtic Old Boys',
    'Clayton Wanderers ',
    'MFC Redwoods',
    'Rusty Plough',
    'Wizards FC '    
  ]
}

rr8_schedule = {
  1 => [[1, 7], [2, 8], [5, 3], [6, 4]],
  2 => [[3, 1], [4, 2], [6, 8], [7, 5]],
  3 => [[1, 6], [4, 7], [5, 2], [8, 3]],
  4 => [[2, 6], [3, 7], [5, 1], [8, 4]],
  5 => [[1, 2], [4, 3], [6, 5], [7, 8]],
  6 => [[3, 6], [4, 5], [7, 2], [8, 1]],
  7 => [[1, 4], [2, 3], [6, 7], [5, 8]]
}

divisions.each do |div, team_names|
  d = Division.create!(letter: div)

  team_names.each do |name|
    Team.create!(name: name, division: d)
  end

  shuffled = d.teams.shuffle
  rr8_schedule.each do |week, matchups|
    matchups.each do |matchup|
      h = shuffled[matchup[0] - 1]
      a = shuffled[matchup[1] - 1]
      Game.create!(
        division: d,
        week: week,
        context: :division,
        home_team: h,
        away_team: a
      )
      Game.create!(
        division: d,
        week: week + 7,
        context: :division,
        home_team: a,
        away_team: h
      )
    end
  end
end

Player.create(
  id: 2,
  team_id: 23,
  first: "isaac",
  last: "wilcox",
  city: "berkeley",
  email: nil,
  phone: nil,
  positions: "prefer right midfield. able to play anywhere on de...",
  keeper: "true",
  attendance_estimate: "5",
  ideal_minutes: "30 on 15 off",
  jersey: "12",
  status: "Ready to Register and Pay!",
  age: nil,
  why: "get all the knots out on the soccer field. Social, fun, strenuous, and dynamic. Don't really care about winning as long as everyone brings their best.",
  paid: nil,
  ebssl_card: false,
  created_at: "2016-08-14 01:36:33",
  updated_at: "2016-08-14 01:36:33"
)
Player.create(
  id: 1,
  team_id: 23,
  first: "Mihai",
  last: "Banulescu",
  city: "Berkeley",
  email: nil,
  phone: nil,
  positions: "Forward, midfield (L or C)",
  keeper: "true",
  attendance_estimate: "3 or 4",
  ideal_minutes: "45 to 70",
  jersey: "7",
  status: "Ready to Register and Pay!",
  age: nil,
  why: "I grew up with it and I love the game.  I love the creativity of a perfect pass leading to a goal, or a nice volley.  I'm also in close to the worst shape of my life and I'd love to change that.  I definitely care about winning, but I care more about playing well together and passing.",
  paid: nil,
  ebssl_card: false,
  created_at: "2016-08-14 00:41:30",
  updated_at: "2016-08-14 15:00:01"
)