moment = require 'moment'

module.exports = (robot) ->
  roommates = ['Gregg', 'Alli', 'Meg', 'Eric', 'Robin']
  week = moment().week()

  robot.hear /weekly chores/i, (res) ->
    weeklyChores = [
      'vacuum'
      'sweep and mop'
      'kitchen surfaces'
      'take the trash out'
      'seasonal'
    ]
    assignments = {}
    for chore, i in weeklyChores
      assignments[roommates[((week + i) % roommates.length)]] = weeklyChores[i]
    res.send "#{k}: #{v}\n" for k, v of assignments

  month = moment().month()
  robot.hear /monthly chores/i, (res) ->
    baths = [['Gregg', 'Meg'], ['Alli', 'Eric', 'Robin']]
    monthlyChores = ['Baseboards & cobwebs',
                     'Dusting & surface cleaning',
                     'Doors, door handles, light switches']
    assignments = {}
    bathroomDuty = (bath[month % bath.length] for bath in baths)
    for roommate in bathroomDuty
      assignments[roommate] = 'Your bathroom'
    otherChores = (roommate for roommate in roommates when roommate not in bathroomDuty)
    for roommate, i in otherChores
      assignments[roommate] ?= monthlyChores[(month + i) % monthlyChores.length]
    res.send "#{k}: #{v}\n" for k, v of assignments
