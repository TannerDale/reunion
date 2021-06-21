class Activity
  attr_reader :name, :participants

  def initialize(name)
    @name = name
    @participants = {}
  end

  def add_participant(name, cost)
    @participants[name] = cost
  end

  def total_cost
    @participants.values.sum
  end

  def split
    total_cost / @participants.keys.size
  end

  def owed
    @participants.each.map { |name, cost|
      [name, split - cost]
    }.to_h
  end
end
