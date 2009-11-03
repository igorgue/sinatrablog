# models/blog.rb

class Tag < Sequel::Model
  many_to_many :posts
end

class Post < Sequel::Model
  many_to_many :tags
end
