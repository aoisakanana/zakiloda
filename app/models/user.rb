class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
       :recoverable, :rememberable, :trackable, :validatable, :confirmable,
       :omniauthable, omniauth_providers: [:twitter]
       
       
  def self.from_omniauth(auth)
    #binding.pry
    User.where(provider: auth.provider, uid: auth.uid).first_or_create do |user|
      #binding.pry
      user.provider = auth.provider
      user.uid = auth.uid
      #Twitter_name
      user.username = auth.info.name
      #Twitter_ID
      user.name = auth.info.nickname
      user.email = User.get_email(auth)
      user.password = Devise.friendly_token[0, 16] # ランダムなパスワードを作成 パスワードの最長文字数を遵守すること
      #user.image = auth.info.image.gsub("_normal","") if user.provider == "twitter"
      #binding.pry
    end
    #binding.pry
  end
  
  private

  def self.get_email(auth)
    auth.info.email || "#{auth.uid}-#{auth.provider}@example.com"
  end
  
  
  
end
