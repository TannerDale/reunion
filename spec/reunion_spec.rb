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
end
