get '/api/tags' do
  @tags = Tag.get(params)

  halt @tags.to_json
end
