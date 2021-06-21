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

    detailed = Hash.new { |hash, key| hash[key] = [] }

    all_participants.each do |participant|
      @activities.each do |activity|
        total_participants = activity.participants.size

        if activity.participants.has_key?(participant)
          if activity.owed[participant] < 0
            payees = activity.owed.each.filter_map do |name, amount|
              name if amount > 0
            end

          else
            payees = activity.owed.each.filter_map do |name, amount|
              name if amount < 0
            end
          end

          amount_per = activity.owed[participant] / payees.size
          activity_info = {
            activity: activity.name,
            payees: payees,
            amount: amount_per
          }
          detailed[participant] << activity_info
        end
      end
    end
    detailed
  end
end
