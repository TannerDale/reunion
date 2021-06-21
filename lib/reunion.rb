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

  def summary
    breakout.each.map { |name, amount|
      "#{name}: #{amount}"
    }.join("\n")
  end

  def detailed_breakout
    all_participants = @activities.map { |activity|
      activity.participants.keys
    }.flatten.uniq

    all_participants.map { |participant|
      participant_activity_info = @activities.filter_map do |activity|
        activity_participants = activity.participants.keys

        if activity_participants.include?(participant)
          payees = activity.owed.each.filter_map do |name, amount|
            if activity.owed[participant] < 0
              name if amount > 0
            else
              name if amount < 0
            end
          end
          amount_per = activity.owed[participant] / payees.size
          {
            activity: activity.name,
            payees: payees,
            amount: amount_per
          }
        end

      end
      [participant, participant_activity_info]
    }.to_h
  end
end
