class Task < ActiveRecord::Base
  attr_accessible :description, :completed, :list_id, :deadline
  validates :description, :presence => true

  # The belongs_to association is described here: 
  # http://guides.rubyonrails.org/association_basics.html#the-belongs_to-association
  # It requires us to add the field 'list_id' to the tasks table.
  belongs_to :list

  def mark_complete
    self.update_attributes(completed: true)
  end

  def days_left_to_complete
    (deadline.to_date - Date.today).to_i
  end
end
