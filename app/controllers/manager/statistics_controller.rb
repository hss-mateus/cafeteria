class Manager::StatisticsController < Manager::ApplicationController
  def index
    @sales_count = Order
      .served
      .group_by_month(:served_at, last: 12)
      .count
      .transform_keys { I18n.l(_1, format: "%b %y") }

    @sales_amount = Order
      .served
      .group_by_month(:served_at, last: 12)
      .sum(:liquid_value_cents)
      .transform_keys { I18n.l(_1, format: "%b %y") }
      .transform_values { Money.to_value(_1) }

    @most_sold_products = OrderItem
      .joins(:order, :product)
      .where(order: { status: :served, served_at: 1.year.ago.. })
      .group(:product)
      .sum(:quantity)
      .transform_keys(&:name)
      .sort_by(&:second)
      .last(10)
      .reverse
  end
end
