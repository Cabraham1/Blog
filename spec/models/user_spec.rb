require 'rails_helper'

RSpec.describe User, type: :model do
  describe "validations" do
    it "is valid with valid attributes" do
      user = User.new(name: "John Doe", posts_counter: 3)
      expect(user).to be_valid
    end

    it "is not valid with a blank name" do
      user = User.new(name: "", posts_counter: 3)
      expect(user).not_to be_valid
      expect(user.errors[:name]).to include("can't be blank")
    end

    it "is not valid with posts_counter as a non-integer or negative value" do
      user = User.new(name: "John Doe", posts_counter: 2.5)
      expect(user).not_to be_valid
      expect(user.errors[:posts_counter]).to include("must be an integer")

      user.posts_counter = -1
      expect(user).not_to be_valid
      expect(user.errors[:posts_counter]).to include("must be greater than or equal to 0")
    end
  end
end
