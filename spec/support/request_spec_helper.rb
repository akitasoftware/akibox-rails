module RequestSpecHelper
  # Parse JSOn response to ruby hash
  def json
    JSON.parse(response.body)
  end
end
