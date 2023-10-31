require 'rails_helper'

RSpec.describe Subscription, type: :model do
  describe "relationships" do 
    it { should belong_to :customer }
    it { should belong_to :tea }
  end

  describe "validations" do 
    it { should validate_presence_of :title }
    it { should validate_presence_of :status }
    it { should validate_presence_of :frequency }
    it { should validate_presence_of :price }
  end

  describe "instance methods" do 
    it "#cancel_subscription" do 
      customer = create(:customer)
      tea = create(:tea)
      subscription = create(:subscription, status: "Active", customer_id: customer.id, tea_id: tea.id) 

      expect(subscription.status).to eq("Active")

      subscription.cancel_subscription

      expect(subscription.status).to eq("Cancelled")
    end
  end
end
