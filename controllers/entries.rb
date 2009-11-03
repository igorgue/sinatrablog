# controllers/entries.rb

# index
get '/' do
  @posts = Post.all

  erb :index
end

# new post form
get '/posts/new' do
  erb :new
end

# edit post form
get '/posts/edit/:id' do
  @post = Post.find :id => params[:id]
  
  if @post
    erb :edit
  else
    redirect "/"
  end
end

get '/posts/:id' do
  @post = Post.find :id => params[:id]

  if @post
    erb :show
  else
    redirect "/"
  end
end

put '/posts' do
  Post.find_or_create :title => params[:title], :body => params[:body]

  redirect "/"
end

post '/posts/:id' do
  post = Post.find :id => params[:id]

  if post
    post.title = params[:title]
    post.body = params[:body]

    post.save
  end

  redirect "/"
end

delete '/posts/:id' do
  post = Post.find :id => params[:id]

  if post
    post.destroy
  end

  redirect "/"
end

# error handling
error do
  erb :status_500
end

not_found do
  erb :status_404
end
