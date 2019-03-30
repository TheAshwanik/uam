module ApplicationHelper
	  def js_page_specific_include
    page_specific_js = params[:controller] + '_' + params[:action]
    if Rails.application.assets.find_asset(page_specific_js).nil?
      javascript_include_tag 'application'
				#, 'data-turbolinks-track' => true
    else
      javascript_include_tag 'application', page_specific_js
				#, 'data-turbolinks-track' => true
    end
  end
end
