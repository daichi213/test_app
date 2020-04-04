class User < ApplicationRecord
    validates :name , presence: true
    validates :email , presence: true
    validates :password , presence: true

    #クラスはselfとして表されるため、postsメソッドではwhereメソッドの引数にselfを使用する
    def posts
        return Post.where(user_id: self.id)
    end
end
