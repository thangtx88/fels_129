class StaticPagesController < ApplicationController
 def home
    show_data_user(current_user) if user_signed_in?
  end
end
