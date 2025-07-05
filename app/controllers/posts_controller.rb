class PostsController < ApplicationController
  before_action :authenticate_user!, only: [ :new, :create ]

  def index
  end

  def new
    @post = Post.new
  end

  def create
    @post = Post.new(post_params)
    @post.user_id = current_user.id if current_user

    if @post.save
      redirect_to root_url, notice: "Post saved successfully!"
    else
      flash.now[:error] = "Post cannot be saved."
      render :new, status: :unprocessable_entity
    end
  end

  private

    def post_params
      params.expect(post: [ :title, :body ])
    end
end
