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
    number_to_currency(Money.new(cents:))
  end

  def update_flash(message:, type: :notice)
    turbo_stream.update(:flash) do
      render("shared/flash", type:, message:)
    end
  end
end
