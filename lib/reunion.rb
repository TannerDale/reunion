require './lib/activity'

class Reunion
  attr_reader :name, :activities

  def initialize(name)
    @name = name
    @activities = []
  end

  def add_activity(activity)
    @activities << activity
  end

  def total_cost
    @activities.sum { |activity| activity.total_cost }
  end

  def breakout
    total = Hash.new { |hash, key| hash[key] = 0 }
    @activities.each do |activity|
      activity.owed.each do |name, amount|
        total[name] += amount
      end
    end
    total
  end
end
