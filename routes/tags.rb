get '/tags' do
  @tags = Tag.get(params)

  content_type :html
  halt erb :tags_index
end
