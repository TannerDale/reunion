require './lib/activity'

RSpec.describe 'Activity' do

  it 'can add an activity' do
    activity = Activity.new("Brunch")

    expect(activity.name).to eq("Brunch")
    expect(activity.participants).to eq({})
  end
end
