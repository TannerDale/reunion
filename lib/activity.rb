class Activity
  attr_reader :name, :participants

  def initialize(name)
    @name = name
    @participants = {}
  end
end
