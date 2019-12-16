class ApplicationController < ActionController::Base
  include ActionView::Helpers::NumberHelper
  before_action :configure_permitted_parameters, if: :devise_controller?

  layout :detect_layout

  helper_method :f7_request?, :rails_routes, :data_name
  helper_method :no_back?

  def detect_layout
    f7_request? ? 'template' : 'application'
  end

  def f7_request?
    request.format == '*/*'
  end

  def default_url_options(options={})
    {time: Time.current.strftime('%Q')}
  end

  def rails_routes
    routes = []
    Rails.application.routes.routes.each do |route|
      route_string = route.path.spec.to_s
      if !route_string.start_with?('/admin', '/assets', '/rails', '/cable')
        routes << {path: route_string.gsub('(.:format)', ''), componentUrl: route_string.gsub('(.:format)', '').gsub(':id', '{{id}}').gsub(/\:([^\/]+)_id/, '{{\1_id}}').gsub(':time', '{{time}}')}
      end
    end
    routes.uniq
  end

  def data_name
    "#{controller_name}-#{action_name}#{params[:id].present? ? '-' + params[:id] : ''}"
  end

  def no_back?
    [nil, request.url].include?(request.env['HTTP_REFERER'])
  end

  def simple_time(time = nil)
    time.methods.include?(:strftime) ? time&.strftime('%m/%d %H:%M') : ''
  end

  def sort_params(default = {created_at: :desc})
    sort = default.keys.first.to_s
    sort = params[:sort] if params[:sort]
    order = default.values.first.to_s
    order = params[:order] if params[:order]
    params[:sort] = sort
    params[:order] = order
    sort_params = nil
    if params[:sort]
      sort_params = {params[:sort].to_sym => params[:order].to_sym || :desc}
    else
      sort_params = default
    end
    sort_params
  end

  def configure_permitted_parameters
    added_attrs = %i{name thumbnail address1 address2 zipcode phone gender student_card_image accept_sms accept_email}
    devise_parameter_sanitizer.permit :sign_up, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: added_attrs
  end
end
