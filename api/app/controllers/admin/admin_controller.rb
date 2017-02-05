class Admin::AdminController < ApplicationController
  http_basic_authenticate_with name: "admin", password: "1em1bilhao"
end
