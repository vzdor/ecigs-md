module AdminHelper
  def admin_title(page_title, show_title = true)
    title("[Admin] #{page_title}", show_title)
  end
end
