moment = require 'moment'

ROOMMATES = ['Gregg', 'Alli', 'Meg', 'Eric', 'Robin']
SEASONAL_CHORE = "Pick up the apples"
WEEKLY_CHORES = ['vacuum'
                 'sweep and mop'
                 'kitchen surfaces'
                 'take the trash out'
                 SEASONAL_CHORE]

MONTHLY_CHORES = ['Baseboards & cobwebs',
                 'Dusting & surface cleaning',
                 'Doors, door handles, light switches']

weekly_assignments = ->
  week = moment().week()
  assignments = {}
  for chore, i in WEEKLY_CHORES
    assignments[ROOMMATES[((week + i) % ROOMMATES.length)]] = WEEKLY_CHORES[i]
  assignments


monthly_assignments = ->
  month = moment().month()
  BATHROOMS = [['Gregg', 'Meg'], ['Alli', 'Eric', 'Robin']]
  assignments = {}
  bathroomDuty = (bath[month % bath.length] for bath in BATHROOMS)
  for roommate in bathroomDuty
    assignments[roommate] = 'Your bathroom'
  otherChores = (roommate for roommate in ROOMMATES when roommate not in bathroomDuty)
  for roommate, i in otherChores
    assignments[roommate] = MONTHLY_CHORES[(month + i) % MONTHLY_CHORES.length]
  assignments

module.exports = (robot) ->
  robot.hear /weekly chores/i, (res) ->
    res.send "#{k}: #{v}\n" for k, v of weekly_assignments()

  robot.hear /monthly chores/i, (res) ->
    res.send "#{k}: #{v}\n" for k, v of monthly_assignments()
