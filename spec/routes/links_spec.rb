describe 'LinkDump Service' do

  def app
    Sinatra::Application
  end

  it "should load the home page" do
    get '/'
    expect(last_response).to be_ok
    expect(last_response.body).to eq("wubalubadubdub\n")
  end
end
