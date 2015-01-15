require 'sinatra'
require 'data_mapper'

DataMapper.setup(
	:default,
	'mysql://root@localhost/blogs'
)

class Blog
	include DataMapper::Resource
	property :id, Serial
	property :title, String
	property :date, String
	property :blog, String
end

DataMapper.finalize.auto_upgrade!

get '/' do
	@blogs = Blog.all
	erb :index, layout: :layout
end

get '/newblog' do
	erb :create_blog, layout: :layout
end

post '/create_blog' do
	p params
	@blog = Blog.new
	@blog.title = params[:title]
	@blog.date = params[:date]
	@blog.blog = params[:blog]
	@blog.save
	redirect to '/'
end

get '/blog/:id' do
	@blog = Blog.get params[:id]
	erb :display_blogs
end

delete '/delete_blog/:id' do 
	@blog = Blog.get params[:id]
	@blog.destroy
	redirect to '/'
end

get '/update_blog/:id' do
	@blog = Blog.get params[:id]
	erb :update_blog
end

patch '/update/:id' do
	@blog = Blog.get params[:id]
	@blog.update title:params[:title]
	@blog.update date:params[:date]
	@blog.update blog:params[:blog]
	redirect to '/'
end





