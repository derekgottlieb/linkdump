describe "models/links" do
  before(:all) do
    ActiveRecord::FixtureSet.create_fixtures(File.join(File.dirname(__FILE__), "..", "fixtures"), "links")
  end

  def app
    Sinatra::Application
  end

  it "should return all link fixtures" do
    expect(Link.all.size).to eq(5)
  end

  context "validations" do
    it "should validate url is specified" do
      expect(Link.create({}).save).to be(false)
    end

    it "should validate url is unique" do
      duplicate_url = Link.all.first["url"]
      expect(Link.create({"url" => duplicate_url}).save).to be(false)
    end
  end
end
