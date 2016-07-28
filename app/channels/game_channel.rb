# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class GameChannel < ApplicationCable::Channel
  def subscribed
     stream_from "player_#{current_user}"
     Match.create(current_user)
  end

  def unsubscribed
    Game.withdraw(current_user)
    Match.remove(current_user)
  end

  def take_turn(data)
    Game.take_turn(current_user, data)
  end

  def new_game()
    Game.new_game(current_user)
  end
end
