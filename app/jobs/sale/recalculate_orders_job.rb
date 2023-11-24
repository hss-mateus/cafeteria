class Sale::RecalculateOrdersJob < ApplicationJob
  def perform(sale)
    sale.product.orders.scratch.each(&:calculate_values!)
  end
end
