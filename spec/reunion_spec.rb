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

  it 'has a summary' do
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

    expect(reunion.summary).to eq("Maria: -10\nLuther: -30\nLouis: 40")
  end

  it 'has a detailed breakout' do
    reunion = Reunion.new("2107 BE")

    activity_1 = Activity.new("Brunch")
    activity_1.add_participant("Maria", 20)
    activity_1.add_participant("Luther", 40)

    activity_2 = Activity.new("Drinks")
    activity_2.add_participant("Maria", 60)
    activity_2.add_participant("Luther", 60)
    activity_2.add_participant("Louis", 0)

    activity_3 = Activity.new("Bowling")
    activity_3.add_participant("Maria", 0)
    activity_3.add_participant("Luther", 0)
    activity_3.add_participant("Louis", 30)

    activity_4 = Activity.new("Jet Skiing")
    activity_4.add_participant("Maria", 0)
    activity_4.add_participant("Luther", 0)
    activity_4.add_participant("Louis", 40)
    activity_4.add_participant("Nemo", 40)

    reunion.add_activity(activity_1)
    reunion.add_activity(activity_2)
    reunion.add_activity(activity_3)
    reunion.add_activity(activity_4)

    the_breakout = {
      "Maria" => [
       {
          activity: "Brunch",
          payees: ["Luther"],
          amount: 10
       },
       {
          activity: "Drinks",
          payees: ["Louis"],
          amount: -20
       },
       {
          activity: "Bowling",
          payees: ["Louis"],
          amount: 10
       },
       {
          activity: "Jet Skiing",
          payees: ["Louis", "Nemo"],
          amount: 10
        }
      ],
      "Luther" => [
       {
          activity: "Brunch",
          payees: ["Maria"],
          amount: -10
        },
       {
          activity: "Drinks",
          payees: ["Louis"],
          amount: -20
        },
       {
          activity: "Bowling",
          payees: ["Louis"],
          amount: 10
        },
       {
          activity: "Jet Skiing",
          payees: ["Louis", "Nemo"],
          amount: 10
        }
      ],
      "Louis" => [
        {
          activity: "Drinks",
          payees: ["Maria", "Luther"],
          amount: 20
       },
       {
          activity: "Bowling",
          payees: ["Maria", "Luther"],
          amount: -10
       },
       {
          activity: "Jet Skiing",
          payees: ["Maria", "Luther"],
          amount: -10
        }
      ],
      "Nemo" => [
       {
          activity: "Jet Skiing",
          payees: ["Maria", "Luther"],
          amount: -10
        }
      ]
    }

    expect(reunion.detailed_breakout).to eq(the_breakout)
  end
end
