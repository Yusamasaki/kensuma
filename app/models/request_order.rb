class RequestOrder < ApplicationRecord
  belongs_to :order, optional: true
  belongs_to :business

  enum status: { editing: 0, completed: 1, request: 2 }

  has_closure_tree
end