class CommentsController < ApplicationController

  before_filter :authenticate, :only => :destroy
  respond_to :html, :js, :xml

  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.create(params[:comment])
    #redirect_to post_path(@post)
    respond_with @comment if @comment.save

    #如果评论保存成功, rails将寻找相应的模板, 如果存在 create.html.erb 将渲染html,
    #如果存在 create.js.erb 当渲染js.
  end

  def destroy
    @post = Post.find(params[:post_id])
    @comment = @post.comments.find(params[:id])
    @comment.destroy
    redirect_to(post_path(@post))
  end
end
