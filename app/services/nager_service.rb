class NagerService
  def upcoming_holidays
    @_holidays ||= get_url("/api/v3/NextPublicHolidays/US")
  end

  def get_url(url)
    response = conn.get(url)
    parse_data(response)
  end

  private
  def conn
    Faraday.new("https://date.nager.at")
  end

  def parse_data(response)
    JSON.parse(response.body, symbolize_names: true)
  end
end
