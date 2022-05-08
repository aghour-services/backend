# frozen_string_literal: true

module ArticlesHelper
  def status(status)
    label_color = \
      case status
      when 'published'
        'success'
      when 'draft'
        'warning'
      end
    "<span class='badge badge-#{label_color}'>#{status}</span>".html_safe
  end
end
