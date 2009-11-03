# app.rb
require 'rubygems'
require 'sinatra'
require 'sequel'

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

load 'controllers/entries.rb'
