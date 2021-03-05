describe "routes/links" do
  before(:all) do
    ActiveRecord::FixtureSet.create_fixtures(File.join(File.dirname(__FILE__), "..", "fixtures"), "links")
  end

  include AuthHelper
  before(:each) do
    http_login
  end

  def app
    Sinatra::Application
  end

  context "/" do
    it "should respond with html" do
      get "/"
      expect(last_response).to be_ok
      expect(last_response.content_type).to eq("text/html;charset=utf-8")
    end
  end
end
