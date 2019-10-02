class Entry < ApplicationRecord
  #Entry model ブログ記事
  belongs_to :author, class_name: "Member", foreign_key: "member_id"
  has_many :images, class_name: "EntryImage"
  has_many :votes, dependent: :destroy
  has_many :voters, through: :votes, source: :member

  STATUS_VALUES = %w(draft member_only public)

  validates :title, presence: true, length: { maximum: 200 }
  validates :body, :posted_at, presence: true
  validates :status, inclusion: { in: STATUS_VALUES }
#ブログ記事を絞り込むスコープ
  scope :common, -> { where(status: "public") }
  scope :published, -> { where("status <> ?","draft") }
  scope :full, ->(member) {
    where("status <> ? OR member_id = ?" , "draft", member.id) }
  scope :readable_for, ->(member) { member ? full(member) : common }

  class << self
    def status_text(status) #statusカラムを日本語化するメソッド
      I18n.t("activerecord.attributes.entry.status_#{status}")
    end

    def status_options
      STATUS_VALUES.map { |status| [status_text(status), status]}
    end
  end
end
