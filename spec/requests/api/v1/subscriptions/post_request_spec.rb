require "rails_helper"

RSpec.describe "POST /api/v1/subscriptions", type: :request do 
  describe "happy path" do 
    it "creates a subscription for a customer" do 
      customer = create(:customer)
      tea = create(:tea)
      
      subscription_params = {
        customer_id: "#{customer.id}",
        tea_id: "#{tea.id}",
        title: "Monthly Cleanse",
        price: 45.00, 
        status: "active",
        frequency: "monthly"
      }

      headers = {"CONTENT_TYPE" => "application/json"}
      
      expect(Subscription.count).to eq(0)
      expect(customer.subscriptions.count).to eq(0)

      post "/api/v1/subscriptions", headers: headers, params: JSON.generate(subscription_params)

      new_subscription = Subscription.last
      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response).to have_http_status(201)
      expect(Subscription.count).to eq(1)
      expect(customer.subscriptions.count).to eq(1)

      expect(response_body[:data][:attributes]).to be_a(Hash)
      expect(response_body).to have_key(:data)

      expect(response_body[:data]).to have_key(:id)
      expect(response_body[:data][:id]).to be_a(String)

      expect(response_body[:data]).to have_key(:type)
      expect(response_body[:data][:type]).to be_a(String)

      expect(response_body[:data]).to have_key(:attributes)
      expect(response_body[:data][:attributes]).to be_a(Hash)

      expect(response_body[:data][:id]).to eq("#{new_subscription.id}")

      expect(response_body[:data][:type]).to eq("subscription")

      expect(response_body[:data][:attributes]).to have_key(:customer_id)
      expect(response_body[:data][:attributes][:customer_id]).to be_an(Integer)

      expect(response_body[:data][:attributes]).to have_key(:tea_id)
      expect(response_body[:data][:attributes][:tea_id]).to be_an(Integer)

      expect(response_body[:data][:attributes]).to have_key(:title)
      expect(response_body[:data][:attributes][:title]).to be_a(String)

      expect(response_body[:data][:attributes]).to have_key(:price)
      expect(response_body[:data][:attributes][:price]).to be_a(Float)

      expect(response_body[:data][:attributes]).to have_key(:status)
      expect(response_body[:data][:attributes][:status]).to be_a(String)

      expect(response_body[:data][:attributes]).to have_key(:frequency)
      expect(response_body[:data][:attributes][:frequency]).to be_a(String)
    end
  end

  describe "sad path" do 
    it "returns an error if customer_id is missing" do 
      customer = create(:customer)
      tea = create(:tea)
      
      subscription_params = {
        tea_id: "#{tea.id}",
        title: "Monthly Cleanse",
        price: 45.00,
        status: "Active",
        frequency: "Monthly"
      }

      headers = { "CONTENT_TYPE" => "application/json" }

      post "/api/v1/subscriptions", headers: headers, params: JSON.generate(subscription_params)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response).to have_http_status(400) 
      expect(Subscription.count).to eq(0)
      expect(customer.subscriptions.count).to eq(0)

      expect(json[:error]).to be_a(Array)
      expect(json[:error][0]).to be_a(Hash)
      expect(json[:error][0]).to have_key(:title)
      expect(json[:error][0][:title]).to be_a(String)
      expect(json[:error][0][:title]).to eq("Validation failed: Customer must exist")

      expect(json[:error][0]).to have_key(:status)
      expect(json[:error][0][:status]).to be_an(Integer)
      expect(json[:error][0][:status]).to eq(400)
    end

    it "returns an error if tea_id is missing" do 
      customer = create(:customer)
      tea = create(:tea)
      
      subscription_params = {
        customer_id: "#{customer.id}",
        title: "Monthly Cleanse",
        price: 45.00,
        status: "Active",
        frequency: "Monthly"
      }

      headers = { "CONTENT_TYPE" => "application/json" }

      post "/api/v1/subscriptions", headers: headers, params: JSON.generate(subscription_params)

      json = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response).to have_http_status(400) 
      expect(Subscription.count).to eq(0)
      expect(customer.subscriptions.count).to eq(0)

      expect(json[:error]).to be_a(Array)
      expect(json[:error][0]).to be_a(Hash)
      expect(json[:error][0]).to have_key(:title)
      expect(json[:error][0][:title]).to be_a(String)
      expect(json[:error][0][:title]).to eq("Validation failed: Tea must exist")

      expect(json[:error][0]).to have_key(:status)
      expect(json[:error][0][:status]).to be_an(Integer)
      expect(json[:error][0][:status]).to eq(400)
    end

    it "returns an error if frequency is missing" do 
      customer = create(:customer)
      tea = create(:tea)

      subscription_params = {
        tea_id: "#{tea.id}",
        customer_id: "#{customer.id}",
        title: "Monthly Cleanse",
        price: 45.00,
        status: "Active"
      }

      headers = { "CONTENT_TYPE" => "application/json" }

      post "/api/v1/subscriptions", headers: headers, params: JSON.generate(subscription_params)

      expect(response).to_not be_successful
      expect(response).to have_http_status(400)
    end
  end
end