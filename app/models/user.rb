class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates_presence_of :username, :email

  has_attached_file :avatar, styles: { medium: '150x150#', thumb: '100x100#' }, default_url: '/images/thumb/missing.png'
  validates_attachment_content_type :avatar, content_type: /\Aimage\/.*\Z/

  has_many :primary_messages, :class_name => 'Message', :foreign_key => 'user_1_id'
  has_many :secondary_messages, :class_name => 'Message', :foreign_key => 'user_2_id'

  has_many :friendships, dependent: :destroy
  has_many :friends, :through => :friendships, dependent: :destroy
  has_many :inverse_friendships, :class_name => 'Friendship', :foreign_key => 'friend_id'
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user

  has_many :reports, dependent: :destroy
  has_many :comments
end
