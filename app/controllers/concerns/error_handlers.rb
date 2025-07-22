module ErrorHandlers
  extend ActiveSupport::Concern

  included do
    rescue_from ActiveRecord::RecordNotFound, with: :handle_not_found
    rescue_from ActiveRecord::RecordInvalid, with: :handle_record_invalid
    rescue_from ArgumentError, with: :handle_argument_error
    rescue_from StandardError, with: :handle_internal_error unless Rails.env.development?
  end

  private

  def handle_not_found(exception)
    log_error(exception)
    redirect_back fallback_location: root_path, alert: "Record not found."
  end

  def handle_record_invalid(exception)
    log_error(exception)
    message = exception.record.errors.full_messages.to_sentence
    redirect_back fallback_location: root_path, alert: "Validation failed: #{message}"
  end

  def handle_argument_error(exception)
    log_error(exception)
    redirect_back fallback_location: root_path, alert: "Invalid input provided."
  end

  def handle_internal_error(exception)
    log_error(exception)
    redirect_to root_path, alert: "Something went wrong. Please try again."
  end

  def log_error(exception)
    Rails.logger.error("[#{exception.class.name}] #{exception.message}")
    Rails.logger.error(exception.backtrace.first(5).join("\n")) if exception.backtrace
  end
end
