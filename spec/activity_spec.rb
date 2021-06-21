require './lib/activity'

RSpec.describe 'Activity' do

  it 'can add an activity' do
    activity = Activity.new("Brunch")

    expect(activity.name).to eq("Brunch")
    expect(activity.participants).to eq({})
  end

  it 'can add a participant' do
    activity = Activity.new("Brunch")

    activity.add_participant("Maria", 20)

    expect(activity.participants).to eq({"Maria" => 20})
  end

  it 'can add multiple participants' do
    activity = Activity.new("Brunch")

    activity.add_participant("Maria", 20)
    activity.add_participant("Luther", 40)

    expect(activity.participants).to eq({"Maria" => 20, "Luther" => 40})
  end

  it 'can calculate total cost' do
    activity = Activity.new("Brunch")
    activity.add_participant("Maria", 20)
    activity.add_participant("Luther", 40)

    expect(activity.total_cost).to eq(60)
  end

  it 'calculates what someone owes' do
    activity = Activity.new("Brunch")
    activity.add_participant("Maria", 20)
    activity.add_participant("Luther", 40)

    split = 60 / 2
    expect(activity.split).to eq(split)
    expect(activity.owed).to eq({"Maria" => 10, "Luther" => -10})
  end
end
