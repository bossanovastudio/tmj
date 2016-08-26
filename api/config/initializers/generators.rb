Rails.application.config.generators do |g|
  g.test_framework      :minitest, spec: false, fixture: false
  g.template_engine     :jbuilder
  g.helper              false
  g.stylesheets         false
  g.javascripts         false
  g.skip_routes         true
end
