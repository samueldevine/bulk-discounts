module ApplicationHelper
  def gh_facade
    GithubFacade.new
  end

  def repository
    @repository = gh_facade.repository
  end

  def users
    @users = gh_facade.users.all
  end

  def nager_facade
    NagerFacade.new
  end

  def upcoming_holidays
    @upcoming_holidays = nager_facade.upcoming_holidays.all
  end
end
