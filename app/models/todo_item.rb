class TodoItem < ActiveRecord::Base
  # attributes
  attr_accessible :task_name, :detail

  # relations
  belongs_to :todo_list
  acts_as_list :scope => :todo_list

  # validations
  validates :task_name, presence: true


end
