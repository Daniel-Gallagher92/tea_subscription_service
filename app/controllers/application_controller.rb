class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record

  def render_invalid_record(exception)
    render json: { error: [
                            title: exception.message,
                            status: 400
                            ]
                          }, status: 400
  end
  
end
