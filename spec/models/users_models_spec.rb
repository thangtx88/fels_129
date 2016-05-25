require "rails_helper"

  RSpec.describe User, type: :model do
    context "user" do
      let(:user) do
        FactoryGirl.create :user
      end

      subject{user}
       describe "#name" do
         it(:name) {is_expected.to_not be_nil}
      end

      describe "#email" do
        it(:email) {is_expected.to_not be_nil}
      end

      describe "#password" do
        it(:password) {is_expected.to_not be_nil}
      end
    end

    context "when name is too long" do
      before {subject.name = Faker::Lorem.characters(55)}
      it {is_expected.not_to be_valid}
    end
  end
