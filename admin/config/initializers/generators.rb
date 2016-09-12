Rails.application.config.generators do |g|
  g.test_framework      :minitest, fixture: false
  g.helper              false
  g.stylesheets         false
  g.javascripts         false
  g.skip_routes         true
end
