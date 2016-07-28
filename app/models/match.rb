class Match < ApplicationRecord
  def self.create(current_user)
    if !REDIS.get("matches").blank?
      if REDIS.get("matches").exclude? current_user.to_s
        # Get the uuid of the player waiting
        opponent = REDIS.get("matches")
        Game.start(current_user, opponent)
        # Clear the waiting key as no one new is waiting
        REDIS.set("matches", nil)
      end
    else
      REDIS.set("matches", current_user)
    end
  end

  def self.remove(current_user)
    if current_user.to_s == REDIS.get("matches")
      REDIS.set("matches", nil)
    end
  end

  def self.clear_all
    REDIS.del("matches")
  end
end
