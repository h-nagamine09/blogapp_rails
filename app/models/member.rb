class Member < ApplicationRecord
  has_secure_password #パスワードの保存と認証のための仕組み gemfileのbcryptを有効にすることによって使用可

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

  class << self
    def search(query)
      rel = order("number")
      if query.present?
        rel = rel.where("name LIKE ? OR full_name LIKE ?",
        "%#{query}%","%#{query}%")
      end
      rel
    end
  end
end
