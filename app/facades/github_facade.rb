class GithubFacade
  def repository
    repository = service.repository
    GithubRepo.new(repository)
  end

  def users
    users = service.users
    GithubUsers.new(users)
  end

  private
  def service
    GithubService.new
  end
end
