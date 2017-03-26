get '/api/links' do
  halt Link.get(params).to_json
end

get '/api/links/:id' do
  Link.where(id: params['id']).first.to_json
end

post '/api/links' do
  protected_json!
  request.body.rewind
  request_payload = JSON.parse(request.body.read)

  request_payload['title'] = Mechanize.new.get(request_payload.fetch('url')).title
  link = Link.new(request_payload)

  if link.save
    link.to_json
  else
    halt 422, link.errors.full_messages.to_json
  end
end

put '/api/links/:id' do
  protected_json!
  link = Link.where(id: params['id']).first

  if link
    link.url = params.fetch('url', link.url)

    if link.save
      link.to_json
    else
      halt 422, link.errors.full_messages.to_json
    end
  end
end

delete '/api/links/:id' do
  protected_json!
  link = Link.where(id: params['id'])

  if link.destroy_all
    {success: "ok"}.to_json
  else
    halt 500
  end
end
