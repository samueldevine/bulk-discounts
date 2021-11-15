module ApplicationHelper
  def facade
    GithubFacade.new
  end

  def repository
    @repository = facade.repository
  end

  def users
    @users = facade.users.all
  end
end
