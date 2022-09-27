class OrderDetail < ApplicationRecord
  enum making_status: { production_not_possible: 0, production_pending: 1, in_production: 2, production_complete: 3}
  belongs_to :item
  belongs_to :order
end
