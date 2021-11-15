class GithubUserRepository
  attr_reader :all

  def initialize(data)
    @all = create_users(data)
  end

  def create_users(data)
    data.map do |row|
      GithubUser.new(row)
    end
  end
end
