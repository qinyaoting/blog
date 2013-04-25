class Post < ActiveRecord::Base

  # 0 现在有attr_accessible了
  attr_accessible :content, :name, :title


  # 1 为post模型添加一些验证：
  validates :name, :presence => true
  validates :title, :presence => true, :length => {:minimum => 5}

  has_many :comments, :dependent => :destroy
  #  假如有一个实例变量 @post 包含一条 post，那么你可以使用 @post.comments 来检索所有该 post 中的 comment。
  #   删除关联对象   :dependent => :destroy



  has_many :tags #实际上对于标签来说应该是一个多对多的关联, 为了方便教程我在这里使用一对多关系
  accepts_nested_attributes_for :tags, :allow_destroy => :true,:reject_if => proc { |attrs| attrs.all? { |k, v| v.blank? } }
  #:allow_destroy 告诉rails在视图上显示一个移除复选框, 而 :reject_if 将会阻止任何空属性的标签的保存.现在我们修改 views/posts/_form.erb 模板来加入tag:
end
