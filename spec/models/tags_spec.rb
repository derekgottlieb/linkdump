describe 'models/tags' do
  before(:all) do
    ActiveRecord::FixtureSet.create_fixtures(File.join(File.dirname(__FILE__), '..', 'fixtures'), 'tags')
  end

  def app
    Sinatra::Application
  end

  it "should return all tag fixtures" do
    expect(Tag.all.size).to eq(3)
  end

  context 'create_any_new_tags method' do
    it "should create a new tag when only one is specified" do
      orig_tag_count = Tag.all.size
      Tag.create_any_new_tags("newtag")
      new_tag_count = Tag.all.size
      expect(new_tag_count).to eq(orig_tag_count + 1)
    end

    it "should create a new tag when more than one are specified" do
      orig_tag_count = Tag.all.size
      Tag.create_any_new_tags(Tag.all.first["name"] + ",anothernewtag")
      new_tag_count = Tag.all.size
      expect(new_tag_count).to eq(orig_tag_count + 1)
    end
  end

  context 'validations' do
    it "should validate name is specified" do
      expect(Tag.create({}).save).to be(false)
    end

    it "should validate name is unique" do
      duplicate_name = Tag.all.first["name"]
      expect(Tag.create({"name" => duplicate_name}).save).to be(false)
    end
  end
end
