module ApplicationHelper
  def full_title page_title = ""
    if page_title.empty?
      t "basetitle"
    end
  end
end
