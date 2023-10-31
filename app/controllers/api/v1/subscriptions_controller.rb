class Api::V1::SubscriptionsController < ApplicationController 


  def create 
    subscription = Subscription.create!(subscription_params)
    render json: SubscriptionSerializer.new(subscription), status: 201
  end

  private

  def subscription_params 
    params.require(:subscription).permit(:title, :description, :price, :status, :frequency).merge(customer_id: params[:customer_id], tea_id: params[:tea_id])
  end
  
end