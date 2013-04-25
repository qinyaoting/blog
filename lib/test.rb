require "rubygems"
require "active_record"

ActiveRecord::Base.establish_connection(:adapter => "sqlite3",
    :databases => "db/development.sqlite3")




class Post < ActiveRecord::Base

end

order = Post.find(1)




class Test



end