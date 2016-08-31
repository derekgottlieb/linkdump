get '/links' do
  @links = Link.get(params)

  content_type :html
  halt erb :links_index
end
