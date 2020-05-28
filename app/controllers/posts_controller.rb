class PostsController < ApplicationController
    def new
        @post = Post.new
    end

    def create
        @post = current_user.posts.build(post_params)
        if @post.save

        flash.notice = "Post '#{@post.title}' Created!"

        redirect_to post_path(@post)
        else
            render :new
        end   
    end

    def show
        @post = Post.find(params[:id])
        @comment = Comment.new
    end

    def destroy
        @post = Post.find(params[:id])
        @post.destroy

        flash.notice = "Post '#{@post.title}' Deleted!"

        redirect_to action: "index"
    end

    def index
        @posts = []
        current_user.posts.each do |post|
            @posts.push(post)
        end
        current_user.friends.each do |friend|
            friend.posts.each do |fpost|
                @posts.push(fpost)
            end
        end
        @posts = @posts.sort_by(&:created_at).reverse
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        @post = Post.find(params[:id])
        @post.update(post_params)

        flash.notice = "Post '#{@post.title}' Updated!'"

        redirect_to post_path(@post)
    end

    private
    def post_params
        params.require(:post).permit(:title, :body, :user_id)
    end
end
