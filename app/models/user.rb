class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :confirmable, :registerable,
         :recoverable, :rememberable, :trackable, :validatable

  validates :name, presence: true
  has_many :solutions

  has_many :problems, through: :solutions

  has_attached_file :avatar, :styles => { :medium => "300x300>", :thumb => "100x100>" }, :default_url => "/images/missing.png"

  has_many :created_problems, class_name: 'Problem'

  has_many :sent_problems

  has_many :friendships
  has_many :friends, :through => :friendships
  has_many :inverse_friendships, :class_name => "Friendship", :foreign_key => "friend_id"
  has_many :inverse_friends, :through => :inverse_friendships, :source => :user
  
  has_reputation :votes,
      :source => [
          { :reputation => :votes, :of => :problems, :aggregated_by => :sum },
          { :reputation => :votes, :of => :solutions, :aggregated_by => :sum }]
 
  # has_reputation :votes, source: {reputation: :votes, of: :solutions}, aggregated_by: :sum

  include PgSearch
  pg_search_scope :search, against: :name,
    using: {tsearch: {dictionary: "english"}}
  
  def self.text_search(query)
    search(query)
  end
end
