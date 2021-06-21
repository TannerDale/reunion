require './lib/reunion'

RSpec.describe 'Reunion' do
  it 'has a name' do
    reunion = Reunion.new("2107 BE")

    expect(reunion.name).to eq("2107 BE")
  end

  it 'has no activities by default' do
    reunion = Reunion.new("2107 BE")

    expect(reunion.activities).to eq([])
  end

  it 'can add activities' do
    reunion = Reunion.new("2107 BE")

    activity_1 = Activity.new("Brunch")
    reunion.add_activity(activity_1)

    expect(reunion.activities.size).to eq(1)
  end

  it 'has a total cost' do
    reunion = Reunion.new("2107 BE")

    activity_1 = Activity.new("Brunch")
    reunion.add_activity(activity_1)
    activity_1.add_participant("Maria", 20)
    activity_1.add_participant("Luther", 40)

    expect(reunion.total_cost).to eq(60)

    activity_2 = Activity.new("Drinks")
    activity_2.add_participant("Maria", 60)
    activity_2.add_participant("Luther", 60)
    activity_2.add_participant("Louis", 0)
    reunion.add_activity(activity_2)

    expect(reunion.total_cost).to eq(180)
  end

  it 'has a breakout' do
    reunion = Reunion.new("2107 BE")

    activity_1 = Activity.new("Brunch")
    activity_1.add_participant("Maria", 20)
    activity_1.add_participant("Luther", 40)
    reunion.add_activity(activity_1)

    activity_2 = Activity.new("Drinks")
    activity_2.add_participant("Maria", 60)
    activity_2.add_participant("Luther", 60)
    activity_2.add_participant("Louis", 0)
    reunion.add_activity(activity_2)

    expect(reunion.breakout).to eq({"Maria" => -10, "Luther" => -30, "Louis" => 40})
  end
end
