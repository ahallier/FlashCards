require 'spec_helper'
require 'rails_helper'

describe UsersController, :type => :controller do
    describe User do
  it "is valid with email, password" do
    u = create(:user)
    expect(u).to be_valid
  end

  it "is invalid without email" do
    u = build(:user, :email=> nil)
    expect(u).to have(1).errors_on(:email)
  end
  
  it "is invalid without name" do
    u = build(:user, :name=> nil)
    expect(u).to have(1).errors_on(:name)
  end

end
end