module ApplicationHelper

  def twitterized_type(type)
    case type
      when :alert then "alert-block"
      when :error then "alert-error"
      when :notice then "alert-info"
      when :success then "alert-success"
      else type.to_s
    end
  end

end
