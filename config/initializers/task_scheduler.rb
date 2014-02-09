require File.expand_path('../../../config/boot',        __FILE__)
require File.expand_path('../../../config/environment', __FILE__)

require './app/mailers/user_mailer.rb'
require './app/controllers/users_controller.rb'

require 'rufus/scheduler'

scheduler = Rufus::Scheduler.new

scheduler.every('1w') do
	puts "Emailing problems"
	UsersController.send_problems_to_users
end