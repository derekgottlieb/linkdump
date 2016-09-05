describe 'routes/api/tags' do
  before(:all) do
    ActiveRecord::FixtureSet.create_fixtures(File.join(File.dirname(__FILE__), '..', 'fixtures'), 'tags')
  end

  def app
    Sinatra::Application
  end

  context "/api/tags" do
    it "should respond with json" do
      get '/api/tags'
      expect(last_response).to be_ok
      expect(last_response.content_type).to eq("application/json")
    end

    it "should respond with all tags" do
      get '/api/tags'
      tags = JSON.parse(last_response.body)
      expect(tags.size).to eq(Tag.all.size)
    end
  end
end
