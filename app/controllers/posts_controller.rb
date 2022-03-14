class PostsController < ApplicationController

  def new
    @post = Post.new
    @post.place_id = params["place_id"]
  end

  def create
    if @current_user #if logged in 
      @post = Post.new(params["post"])
      @post.user_id = @current_user.id
      @post.save
      redirect_to "/places/#{@post.place.id}"
    end
  end

end
