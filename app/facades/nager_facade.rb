class NagerFacade
  def upcoming_holidays
    NagerHolidayRepository.new(service.upcoming_holidays)
  end

  private
  def service
    @_service ||= NagerService.new
  end
end
