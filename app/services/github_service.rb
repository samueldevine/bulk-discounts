class GithubService
  def repository
    @_repository ||= get_url("/repos/samueldevine/bulk-discounts")
  end

  def users
    @_users ||= get_url("/repos/samueldevine/bulk-discounts/contributors")
  end

  def get_url(url)
    response = conn.get(url)
    parse_data(response)
  end

  private
  def conn
    Faraday.new("https://api.github.com")
  end

  def parse_data(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
