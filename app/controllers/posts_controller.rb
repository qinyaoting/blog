class PostsController < ApplicationController


  # 使用 before_filter 过滤器. 该方法将在每个动作执行前运行, 除非一些通过 :except 设置的方法:
  before_filter :authenticate, :except => [:index, :show]
  respond_to :html, :js, :xml
  # GET /posts
  # GET /posts.json
  def index
    #@posts = Post.all

    @posts = Post.page(params[:page]).per(2)

    #require 'debugger'; debugger
    #list=      #查看当前运行处代码
    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @posts }
    end
  end

  # GET /posts/1
  # GET /posts/1.json
  def show

    #   http://localhost:3000/posts/1
    @post = Post.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/new
  # GET /posts/new.json
  def new
    @post = Post.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @post }
    end
  end

  # GET /posts/1/edit
  def edit

    #   http://localhost:3000/posts/1/edit
    @post = Post.find(params[:id])
  end

  # POST /posts
  # POST /posts.json
  def create


    # params[:post]

    @post = Post.new(params[:post])

    respond_to do |format|
      if @post.save

        # ???                    “Post was successfully created.”保存在rails的flash哈希内，我们可以在视图层用<%=flash[:notice]%>查看
        format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render json: @post, status: :created, location: @post }
      else
        format.html { render action: "new" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /posts/1
  # PUT /posts/1.json
  def update

    # 在update方法中，首先rails使用:id参数获取数据库中相应的post记录，然后使用 update_attributes
    #来更新表单中的内容到数据库中。如果更新成功，转到 show 页面，如果更新失败，那么重新回到 edit 页面。
    @post = Post.find(params[:id])

    respond_to do |format|
      if @post.update_attributes(params[:post])
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post = Post.find(params[:id])
    @post.destroy

    #respond_to do |format|
    #  format.html { redirect_to posts_url }
    #  format.json { head :no_content }
    #end
    respond_with(@post)
  end
end
