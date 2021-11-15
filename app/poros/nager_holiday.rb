class NagerHoliday
  attr_reader :date,
              :local_name,
              :name,
              :country_code

  def initialize(data)
    @date         = data[:date]
    @local_name   = data[:localName]
    @name         = data[:name]
    @country_code = data[:countryCode]
  end
end
