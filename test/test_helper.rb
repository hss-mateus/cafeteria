ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

class ActiveSupport::TestCase
  include Sorcery::TestHelpers::Rails::Integration
  include FactoryBot::Syntax::Methods

  parallelize(workers: :number_of_processors)

  def login_user(user = create(:user))
    post session_path, params: { user: { email: user.email, password: "secret" } }
    follow_redirect!
    user
  end
end
