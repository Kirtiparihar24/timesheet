class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :validatable

  validates_presence_of :name, :role

  has_one_attached :avatar

  enum role: %i[teacher admin]

  has_many :time_entries, dependent: :destroy

  def is_my_timesheet?(user_id)
    id == user_id
  end

end
