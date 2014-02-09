
require File.expand_path('../../config/boot',        __FILE__)
require File.expand_path('../../config/environment', __FILE__)
require 'clockwork'
require './app/mailers/user_mailer.rb'
require './app/controllers/users_controller.rb'


Clockwork.every(1.day, "Email Problem") do
	Rails.logger.info "Emailing problems"
	UsersController.send_problems_to_users
end