# frozen_string_literal: true

# == Schema Information
#
# Table name: users
#
#  id                     :bigint           not null, primary key
#  provider               :string           default("email"), not null
#  uid                    :string           default(""), not null
#  encrypted_password     :string           default(""), not null
#  reset_password_token   :string
#  reset_password_sent_at :datetime
#  allow_password_change  :boolean          default(FALSE)
#  remember_created_at    :datetime
#  name                   :string           not null
#  email                  :string           not null
#  status                 :integer          default("not_set"), not null
#  prefecture             :integer          default("未設定"), not null
#  self_introduction      :text
#  tokens                 :json
#  created_at             :datetime         not null
#  updated_at             :datetime         not null
#
class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  include DeviseTokenAuth::Concerns::User

  validates :name, { presence: true, uniqueness: true }
  validates :email, presence: true

  has_many :posts, dependent: :destroy
  has_many :likes, dependent: :destroy
  has_many :comments, dependent: :destroy
  has_many :favorites, through: :likes, source: :post

  enum status: { not_set: 0, elementary_school_principal: 1, junior_high_school_principal: 2, former_elementary_school_principal: 3, former_junior_high_school_principal: 4 },
       _prefix: true
  enum prefecture: { 未設定: 0,
                     北海道: 1, 青森県: 2, 岩手県: 3, 宮城県: 4, 秋田県: 5, 山形県: 6, 福島県: 7,
                     茨城県: 8, 栃木県: 9, 群馬県: 10, 埼玉県: 11, 千葉県: 12, 東京都: 13, 神奈川県: 14,
                     新潟県: 15, 富山県: 16, 石川県: 17, 福井県: 18, 山梨県: 19, 長野県: 20,
                     岐阜県: 21, 静岡県: 22, 愛知県: 23, 三重県: 24,
                     滋賀県: 25, 京都府: 26, 大阪府: 27, 兵庫県: 28, 奈良県: 29, 和歌山県: 30,
                     鳥取県: 31, 島根県: 32, 岡山県: 33, 広島県: 34, 山口県: 35,
                     徳島県: 36, 香川県: 37, 愛媛県: 38, 高知県: 39,
                     福岡県: 40, 佐賀県: 41, 長崎県: 42, 熊本県: 43, 大分県: 44, 宮崎県: 45, 鹿児島県: 46,
                     沖縄県: 47 }, _prefix: true

  # ゲストユーザーが存在しない場合、ゲストユーザーを作成
  def self.guest
    find_or_create_by!(email: 'guest@example.com') do |user|
      user.password = SecureRandom.urlsafe_base64
      user.name = 'ゲストユーザー'
    end
  end
end
