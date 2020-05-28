class LikesController < ApplicationController
    before_action :find_post
    before_action :find_like, only: [:destroy]

    def create
        if already_liked?
            flash[:notice] = "You already liked this post."
        else
            @post.likes.create(user_id: current_user.id)
        end
        redirect_to post_path(@post)
    end

    def destroy
        if !(already_liked?)
            flash[:notice] = "Cannot unlike something you haven't liked"
        else
            @like.destroy
        end
        redirect_to post_path(@post)
    end

    private

    def find_like
        @like = @post.likes.find(params[:id])
    end

    def find_post
        @post = Post.find(params[:post_id])
    end

    def already_liked?
        Like.where(user_id: current_user.id, post_id: params[:post_id]).exists?
    end

end
