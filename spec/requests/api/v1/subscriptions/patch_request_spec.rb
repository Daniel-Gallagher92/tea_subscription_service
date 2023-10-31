require "rails_helper"

RSpec.describe "PATCH /api/v1/subscriptions/:id", type: :request do 
  describe "happy path" do 
    it "updates a subscription status for a customer" do 
      customer = create(:customer)
      tea = create(:tea)
      subscription = create(:subscription, status: "Active", customer_id: customer.id, tea_id: tea.id)

      subscription_status = Subscription.last.status

      expect(subscription_status).to eq("Active")

      headers = {"CONTENT_TYPE" => "application/json"} 
      patch "/api/v1/subscriptions/#{subscription.id}", headers: headers, params: JSON.generate(subscription.cancel_subscription)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response).to have_http_status(200)
      expect(json[:data][:attributes][:status]).to eq("Cancelled")
    end
  end

  describe "sad path" do 
    it 'returns an error if no subscription exists with that id' do
      headers = { 'CONTENT_TYPE' => 'application/json' }

      patch "/api/v1/subscriptions/5", headers: headers
      
      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response.status).to eq(404)
      expect(json[:error][0][:title]).to eq("Couldn't find Subscription with 'id'=5")
      expect(json[:error][0][:status]).to eq(404)
    end
  end
end