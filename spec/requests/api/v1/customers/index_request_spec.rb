require "rails_helper" 

RSpec.describe "GET /api/v1/customers/:id/subscriptions", type: :request do 
  describe "happy path" do 
    it "returns a list of all subscriptions for a customer" do 
      customer = create(:customer)
      tea_1 = create(:tea)
      tea_2 = create(:tea)

      subscription_1 = create(:subscription, status: "Cancelled", customer_id: customer.id, tea_id: tea_1.id)
      subscription_2 = create(:subscription, status: "Active", customer_id: customer.id, tea_id: tea_2.id)

      get "/api/v1/customers/#{customer.id}/subscriptions" 

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to be_successful
      expect(response).to have_http_status(200)

      expect(response_body).to be_a(Hash)

      expect(response_body).to have_key(:data)
      expect(response_body[:data]).to be_an(Array)

      expect(response_body[:data][0]).to be_a(Hash)

      expect(response_body[:data][0]).to have_key(:id)
      expect(response_body[:data][0][:id]).to be_a(String)


      expect(response_body[:data][0][:attributes]).to have_key(:customer_id)
      expect(response_body[:data][0][:attributes][:customer_id]).to be_an(Integer)
      expect(response_body[:data][0][:attributes]).to have_key(:tea_id)
      expect(response_body[:data][0][:attributes][:tea_id]).to be_an(Integer)

      expect(response_body[:data][0]).to have_key(:type)
      expect(response_body[:data][0][:type]).to be_a(String)

      expect(response_body[:data][0]).to have_key(:attributes)
      expect(response_body[:data][0][:attributes]).to be_a(Hash)

      expect(response_body[:data][0][:attributes]).to have_key(:title)
      expect(response_body[:data][0][:attributes][:title]).to be_a(String)

      expect(response_body[:data][0][:attributes]).to have_key(:price)
      expect(response_body[:data][0][:attributes][:price]).to be_a(Float)
    end
  end

  describe "sad path" do 
    it "returns an error message if the customer does not exist" do 
      
      get "/api/v1/customers/1/subscriptions" 

      response_body = JSON.parse(response.body, symbolize_names: true)

      expect(response).to_not be_successful
      expect(response).to have_http_status(404)

      expect(response_body).to be_a(Hash)

      expect(response_body).to have_key(:error)
      expect(response_body[:error][0]).to have_key(:title)
      expect(response_body[:error][0][:title]).to be_a(String)
      expect(response_body[:error][0][:title]).to eq("Couldn't find Customer with 'id'=1")
      expect(response_body[:error][0]).to have_key(:status)
      expect(response_body[:error][0][:status]).to be_an(Integer)
      expect(response_body[:error][0][:status]).to eq(404) 
    end
  end
end