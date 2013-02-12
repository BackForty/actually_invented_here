class PayLeap
  include HTTParty

  class << self
    def configuration
      @configuration ||= YAML.load(Rails.root.join('config', 'gateway.yml'))
    end
  end

  base_uri configuration && configuration['service']
  default_timeout 2

  def request(endpoint, query = {})
    query.merge!(
      Password: configuration[:transaction_key],
      UserName: configuration[:user]
    )
    request = get("/#{endpoint}", :query => query)
    if request.parsed_response
      Response.new(request.parsed_response)
    else
      Response.new(:request => request, :gateway_failed => true)
    end
  rescue Errno::ECONNREFUSED, SocketError
    Response.new(:gateway_failed => true)
  end
end
