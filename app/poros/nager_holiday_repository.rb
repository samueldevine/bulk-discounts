class NagerHolidayRepository
  attr_reader :all

  def initialize(data)
    @all = create_holidays(data[0..2])
  end

  def create_holidays(data)
    data.map do |row|
      NagerHoliday.new(row)
    end
  end
end
