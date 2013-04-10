class UserFile < ActiveRecord::Base
	belongs_to :user
	belongs_to :rapid_file
end
