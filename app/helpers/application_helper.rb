module ApplicationHelper
  def full_title page_title = ""
    if page_title.empty?
      I18n.t "basetitle"
    end
  end
end
