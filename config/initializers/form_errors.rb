class CustomFormBuilder < ActionView::Base::FormBuilder
  def error_for(attribute, **attrs)
    error_message = @object.errors.full_messages_for(attribute).to_sentence

    return if error_message.blank?

    attrs[:class] ||= ""
    attrs[:class] += " invalid-feedback"

    @template.content_tag(:p, error_message, attrs)
  end
end

ActionView::Base.field_error_proc = proc do |html_tag, instance|
  fragment = Nokogiri::HTML.fragment(html_tag)
  field = fragment.at("input,select,textarea")

  error_message = instance.object.errors.full_messages.to_sentence

  next html_tag unless field

  field.add_class("is-invalid")

  fragment.to_s.html_safe
end
