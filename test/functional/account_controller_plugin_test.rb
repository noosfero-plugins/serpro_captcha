require File.dirname(__FILE__) + '/../test_helper'

# Re-raise errors caught by the controller.
class AccountController; def rescue_action(e) raise e end; end

class AccountControllerPluginTest < ActionController::TestCase

  def setup
    @controller = AccountController.new
    @request    = ActionController::TestRequest.new
    @response   = ActionController::TestResponse.new

    @environment = Environment.default
    @environment.enabled_plugins = ['SerproCaptchaPlugin']
    @environment.save!
  end

end
