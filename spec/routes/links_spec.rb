describe 'LinkDump Service' do

  def app
    Sinatra::Application
  end

  it "should load the home page" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to eq("wubalubadubdub\n")
  end

  context "/links" do
    it "should respond with html" do
      get '/links'
      expect(last_response).to be_ok
      expect(last_response.content_type).to eq("text/html;charset=utf-8")
    end
  end
end
