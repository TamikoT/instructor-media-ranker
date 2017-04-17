require "test_helper"

describe UpdateUserModelForGithubLogin do
  let(:update_user_model_for_github_login) { UpdateUserModelForGithubLogin.new }

  it "must be valid" do
    value(update_user_model_for_github_login).must_be :valid?
  end
end
