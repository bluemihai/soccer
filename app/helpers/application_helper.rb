module ApplicationHelper
  def show_bool(value, size=nil)
    value ? image_tag('checkmark.png', width: size, height: size) : image_tag('x.png', width: size, height: size)
  end
end
