require 'rails_helper'

RSpec.describe User, type: :model do
  describe "Validations" do
    it "creates user after validating fields" do
      @user = User.create({
        password: "1234",
        password_confirmation: "1234",
        email: "a@a.com",
        name: "A H"
      })
      expect(@user.errors.full_messages).to match_array([])
    end
    it "validates :password, presence: true" do
      @user = User.create({
        password_confirmation: "1234",
        email: "a@a.com",
        name: "A H"
      })
      expect(@user.errors.full_messages).to include("Password can't be blank")
    end
    it "validates :password_confirmation, presence: true" do
      @user = User.create({
        password: "1234",
        email: "a@a.com",
        name: "A H"
      })
      expect(@user.errors.full_messages).to include("Password confirmation can't be blank")
    end
    it "validates :password and :password_confirmation match" do
      @user = User.create({
        password: "1254",
        password_confirmation: "1234",
        email: "a@a.com",
        name: "A H"
      })
      expect(@user.errors.full_messages).to include("Password confirmation doesn't match Password")
    end
    it "validates :email, presence: true" do
      @user = User.create({
        password: "1234",
        password_confirmation: "1234",
        name: "A H"
      })
      expect(@user.errors.full_messages).to include("Email can't be blank")
    end
    it "validates :email is unique" do
      @user = User.create({
        password: "1234",
        password_confirmation: "1234",
        email: "a@a.com",
        name: "A H"
      })
      @user2 = User.create({
        password: "1234",
        password_confirmation: "1234",
        email: "A@A.com",
        name: "A L"
      })
      expect(@user2.errors.full_messages).to include("Email has already been taken")
    end
    it "validates :name, presence: true" do
      @user = User.create({
        password: "1234",
        password_confirmation: "1234",
        email: "a@a.com"
      })
      expect(@user.errors.full_messages).to include("Name can't be blank")

    end
    it "validates :password, length {minimum:4}" do

      @user = User.create({
        password: "123",
        password_confirmation: "123",
        email: "a@a.com",
        name: "A H"
      })
      expect(@user.errors.full_messages).to include("Password is too short (minimum is 4 characters)")
    end

  end
  describe ".authenticate_with_credentials" do
    it "returns nil if password is incorrect" do
      @user = User.create({
        password: "1234",
        password_confirmation: "1234",
        email: "a@a.com",
        name: "A H"
      })
      expect(@user.authenticate_with_credentials("a@a.com", "4321")).to be_nil
    end
    it "returns nil if email is incorrect" do
      @user = User.create({
        password: "1234",
        password_confirmation: "1234",
        email: "a@a.com",
        name: "A H"
      })
      expect(@user.authenticate_with_credentials("b@b.com", "1234")).to be_nil
    end
    it "returns user if email and password are correct" do
      @user = User.create({
        password: "1234",
        password_confirmation: "1234",
        email: "a@a.com",
        name: "A H"
      })
      expect(@user.authenticate_with_credentials("a@a.com", "1234")).to equal(@user)
    end
    it "returns user if email is correct, but with spaces and password is correct" do
      @user = User.create({
        password: "1234",
        password_confirmation: "1234",
        email: "a@a.com",
        name: "A H"
      })
      expect(@user.authenticate_with_credentials("   a@a.com   ", "1234")).to equal(@user)
    end

    it "returns user if email is correct, but incorrect casing and password is correct" do
      @user = User.create({
        password: "1234",
        password_confirmation: "1234",
        email: "a@a.com",
        name: "A H"
      })

      expect(@user.authenticate_with_credentials("A@A.com", "1234")).to equal(@user)
    end

  end
end
