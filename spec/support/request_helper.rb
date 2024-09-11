module RequestHelper
  def response_json
      JSON.parse(response.body)
  end
end