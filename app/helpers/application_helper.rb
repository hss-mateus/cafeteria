module ApplicationHelper
  include Pagy::Frontend

  def full_title(page_title = "")
    base_title = "Cafeteria"

    if page_title.empty?
      base_title
    else
      "#{page_title} | #{base_title}"
    end
  end

  def flash_color(type)
    case type.to_s
    when "notice" then "primary"
    when "alert" then "warning"
    end
  end

  def flash_icon(type)
    case type.to_s
    when "notice" then "bi-info-circle-fill"
    when "alert" then "bi-exclamation-triangle-fill"
    end
  end

  def cents_to_currency(cents)
    number_to_currency(Money.new(cents:).to_f)
  end

  def update_flash(message:, type: :notice)
    turbo_stream.append(:flash) do
      render("shared/flash", type:, message:)
    end
  end

  def human_quantity(record)
    number = number_with_precision(
      record.quantity,
      precision: 2,
      strip_insignificant_zeros: true
    )

    "#{number}#{record.unit}"
  end

  def status_class(status)
    case status.to_s
    when "scratch" then "secondary"
    when "payment_started" then "info"
    when "payment_succeeded" then "info"
    when "payment_failed" then "danger"
    when "served" then "success"
    end
  end
end
