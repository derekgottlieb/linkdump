describe "routes/api/links" do
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

  context "/api/links" do
    it "should respond with json" do
      get "/api/links"
      expect(last_response).to be_ok
      expect(last_response.content_type).to eq("application/json")
    end

    it "should respond with all tags" do
      get "/api/links"
      links = JSON.parse(last_response.body)
      expect(links.size).to eq(Link.all.size)
    end
  end
end
