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
    res.send (roommates[((week + i) % 5)] + ": " + weeklyChores[i] for chore, i in weeklyChores).join(', \n')

