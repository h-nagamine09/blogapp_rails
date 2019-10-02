class Member < ApplicationRecord
  has_secure_password #パスワードの保存と認証のための仕組み gemfileのbcryptを有効にすることによって使用可

  has_many :entries, dependent: :destroy #ブログ記事は会員に属する
  has_many :votes, dependent: :destroy
  has_many :voted_entries, through: :votes, source: :entry
  has_one_attached :profile_picture
  attribute :new_profile_picture
  attribute :remove_profile_picture, :boolean

  #numberのバリデーション
  validates :number, presence: true, #空かどうかをチェックする
    numericality: {
      only_integer: true, #整数のみ　#1以上100未満の整数、会員の間で重複を禁止
      greater_than: 0, #1以上
      less_than: 100, #100未満
      allow_blank: true
    },
    uniqueness: true
  #nameのバリデーション
    validates :name, presence: true,
    format: {
      with: /\A[A-Za-z][A-Za-z0-9]*\z/,
      allow_blank: true,
      message: :invalid_member_name
    },

    length: {minimum: 2, maximum: 20, allow_blank: true},
    uniqueness: { case_sensitive: false}
  #full_nameのバリデーション
    validates :full_name, presence: true, length: { maximum: 20 }
    validates :email, email: { allow_blank: true}

    attr_accessor :current_password #Current_passwordをMemberクラスに追加
    validates :password, presence: {if: :current_password} #から文字でもnilでもない時に確認

    validate if: :new_profile_picture do
      if new_profile_picture.respond_to?(:content_type)
        unless new_profile_picture.content_type.in?(ALLOWED_CONTENT_TYPES)
          errors.add(:new_profile_picture, :invalid_image_type)
        end
      else
        errors.add(:new_profile_picture, :invaild)
      end
    end

    before_save do
      if new_profile_picture
        self.profile_picture = new_profile_picture
      elsif remove_profile_picture
        self.profile_picture.purge
      end
    end

    def votable_for?(entry)
      entry && entry.author != self && !votes.exists?(entry_id: entry.id)
    end
    
  class << self
    def search(query)
      rel = order("number")
      if query.present?
        rel = rel.where("name LIKE ? OR full_name LIKE ?",
        "%#{query}%","%#{query}%")
      end
    end
  end
end
