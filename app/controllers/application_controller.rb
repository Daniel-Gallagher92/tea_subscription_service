class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordInvalid, with: :render_invalid_record
  rescue_from ActiveRecord::RecordNotFound, with: :render_record_not_found

  def render_invalid_record(exception)
    render json: { error: [
                            title: exception.message,
                            status: 400
                            ]
                          }, status: 400
  end

  def render_record_not_found(exception)
    render json: { error: [
                            title: exception.message,
                            status: 404
                            ]
                          }, status: 404
  end
  

end
