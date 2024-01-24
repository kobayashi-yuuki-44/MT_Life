module ApplicationHelper
  def flash_class(type)
    case type
    when 'notice' then 'alert alert-info'
    when 'success' then 'alert alert-success'
    when 'error' then 'alert alert-error'
    when 'warning' then 'alert alert-warning'
    when 'danger' then 'alert alert-danger'
    else 'alert'
    end
  end
end
