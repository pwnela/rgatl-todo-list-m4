class Task < ActiveRecord::Base
  attr_accessible :description, :completed, :list_id, :deadline, :priority
  validates :description, :presence => true

  # The belongs_to association is described here: 
  # http://guides.rubyonrails.org/association_basics.html#the-belongs_to-association
  # It requires us to add the field 'list_id' to the tasks table.
  belongs_to :list

  # This scope allows us to get a collection of tasks sorted by priority
  # http://guides.rubyonrails.org/active_record_querying.html#scopes
  scope :prioritize, -> { order("priority ASC") }

  def mark_complete
    self.update_attributes(completed: true)
  end

  def days_left_to_complete
    (deadline.to_date - Date.today).to_i
  end
end
