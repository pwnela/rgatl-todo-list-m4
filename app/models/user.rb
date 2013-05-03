class User < ActiveRecord::Base
  # Include default devise modules. Others available are:
  # :token_authenticatable, :confirmable,
  # :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable,
         :rememberable, :trackable

  validates :username, presence: true, uniqueness: true

  # Setup accessible (or protected) attributes for your model
  attr_accessible :username, :password, :password_confirmation, :remember_me

  has_many :lists

  # "after_create" is a callback; after a user is created, the action create_first_list will create a list for the user.
  # Callbacks can be useful, but can also cause a lot of headache if one behaves in a strange way, or if you have several firing in a row.
  # Read about how to use them... or how not to use them here: 
  # http://guides.rubyonrails.org/active_record_validations_callbacks.html#available-callbacks
  after_create :create_first_list

  def create_first_list
    lists.create(name: "To-Do List")
  end

end
