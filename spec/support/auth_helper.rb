module AuthHelper
  def http_login
    basic_authorize(CONFIG["auth_username"], CONFIG["auth_password"])
  end
end
