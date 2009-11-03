# controllers/entries.rb

get '/' do
  @entries = Post.all

  erb :index
end

get '/add' do
  erb :add
end

post '/add' do
  Post.find_or_create :title => params[:title], :body => params[:body]

  redirect "/"
end

get '/delete/?' do
  if params[:id]
    post = Post.find :id => params[:id]

    if post
      post.destroy
    end
  end

  redirect "/"
end
