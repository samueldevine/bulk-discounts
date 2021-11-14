class ApplicationController < ActionController::Base
  facade = GithubFacade.new
  @repository ||= facade.repository
end
