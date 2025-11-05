class ExternalServiceError < StandardError
  attr_reader :status

  def initialize(message = "External service error", status = nil)
    super(message)
    @status = status
  end
end
