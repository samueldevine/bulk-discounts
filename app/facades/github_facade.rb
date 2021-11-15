class GithubFacade
  def repository
    GithubRepo.new(service.repository)
  end

  def users
    GithubUserRepository.new(service.users)
  end

  private
  def service
    @_service ||= GithubService.new
  end
end
