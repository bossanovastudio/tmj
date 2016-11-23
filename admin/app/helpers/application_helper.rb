module ApplicationHelper
  def query_string(key, value)
    permitted_params = [:origin, :status, :content]
    active_params = params.permit(*permitted_params).to_h.slice(*permitted_params)

    active_params[key] = value if permitted_params.include? key

    '?'+ active_params.to_query
  end
end
