require 'gossip'
require 'comment'

class ApplicationController < Sinatra::Base

	get '/' do
		erb :index, locals: {gossips: Gossip.all}

	end

	get '/gossips/new/' do
		erb :new_gossip
	end

	post '/gossips/new/' do
		Gossip.new(params["gossip_author"], params["gossip_content"]).save
		redirect '/'

	end

	get '/gossips/:id/' do
		erb :gossip_page, locals: {
			gossip: Gossip.new("", "").find(params[:id]),
			id_gossip: params[:id]
		}
	end

	get '/gossips/:id/edit/' do
		erb :gossip_page_edit, locals: {
			gossip: Gossip.new("", "").find(params[:id]),
			id_gossip: params[:id]
		}
	end

	post '/gossips/:id/edit/' do
		Gossip.new("", "").update(params[:id], params["gossip_content"])
		redirect '/'
	end

	get '/gossips/:id/comment/' do
		erb :new_gossip_comment, locals: {id_gossip: params[:id]}
	end

	post '/gossips/:id/comment/' do
		Comment.new(params[:id], params["gossip_comment"]).new_comment
		redirect '/'
	end

end