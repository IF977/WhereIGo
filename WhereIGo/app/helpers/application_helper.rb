module ApplicationHelper
  def flash_message
    messages = ""
    [:notice, :info, :warning, :error].each {|type|
      if flash[type]
        messages += "<div class=\"wig-flash\">#{flash[type]}</div>"
      end
    }

    messages
  end
end
