class GithubUsers
  attr_reader :login,
              :contributions

  def initialize(data)
    @login         = data[:login]
    @contributions = data[:contributions]
  end

  def user_and_contributions
    contribution_hash = {}
    @data.each do |user|
      contribution_hash[user[:login]] = [user[:contributions]].first
    end
    contribution_hash
  end
end
