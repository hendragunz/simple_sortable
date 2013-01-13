class TodoList < ActiveRecord::Base
  # attributes
  attr_accessible :name, :description, :todo_items_attributes

  # relations
  has_many :todo_items, :order => "position"

  # capabilities
  accepts_nested_attributes_for :todo_items, :reject_if => proc { |attributes| attributes['task_name'].blank? }

  # validations
  validates :name, presence: true
  validates :description, presence: true

end
