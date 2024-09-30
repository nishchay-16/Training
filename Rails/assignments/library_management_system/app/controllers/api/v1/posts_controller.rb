module Api
  module V1
    class PostsController < ApplicationController
      def index              # GET /api/v1/posts
        posts = Post.all
        render json: posts, status: :ok
      end

      def show               # GET /api/v1/posts/:id
        post = Post.find(params[:id])
        render json: post, status: :ok
      end

      def create             # POST /api/v1/posts
        post = Post.new(post_params)
        if post.save
          render json: post, status: :created
        else
          render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def update            # PUT /api/v1/posts/:id
        post = Post.find(params[:id])
        if post.update(post_params)
          render json: post, status: :ok
        else
          render json: { errors: post.errors.full_messages }, status: :unprocessable_entity
        end
      end

      def destroy            # PUT /api/v1/posts/:id
        post = Post.find(params[:id])
        post.destroy
        render json: { message: 'Post deleted' }, status: :ok
      end

      private

      def post_params
        params.require(:post).permit(:title, :content)
      end
    end
  end
end
