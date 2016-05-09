class StaticPagesController < ApplicationController
 def home
    show_data_user(current_user) if logged_in?
  end
end
