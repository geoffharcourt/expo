require "rails_helper"

RSpec.describe Airport, type: :model do
  it { should validate_presence_of(:city) }
  it { should validate_presence_of(:code) }
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:opened_on) }
end
