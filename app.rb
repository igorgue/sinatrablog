# app.rb
require 'rubygems'
require 'sinatra'
require 'sequel'

class App < Sinatra::Default
  dir = File.dirname(File.expand_path(__FILE__))

  set :public, "#{dir}/media"
  set :static, true

  configure do
    DB = Sequel.sqlite('blog.db')

    DB.create_table? :posts do
      primary_key :id
      varchar :title
      varchar :body
    end

    DB.create_table? :tags do
      primary_key :id
      varchar :title
    end

    load "models/blog.rb"
  end

  helpers do
    include Rack::Utils
    alias :unsafe :escape_html
  end

  # index
  get '/' do
    @posts = Post.all

    erb :index
  end

  # new post form
  get '/posts/new' do
    erb :new
  end

  get '/posts/:id?' do
    @post = Post.find :id => params[:id]

    if @post
      if params[:edit] == "true"
        erb :edit
      else
        erb :show
      end
    else
      redirect "/"
    end
  end

  # create a new post
  post '/posts' do
    post = Post.find_or_create :title => params[:title], :body => params[:body]

    if post
      redirect "/posts/#{post.id}"
    else
      redirect "/"
    end
  end

  put '/posts/:id' do
    post = Post.find :id => params[:id]

    if post
      post.title = params[:title]
      post.body = params[:body]

      post.save
    end

    redirect "/posts/#{params[:id]}"
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
end
