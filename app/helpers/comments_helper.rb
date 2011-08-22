module CommentsHelper
  def simple_comment_format(content)
    simple_format(auto_link(h(content)))
  end
end
