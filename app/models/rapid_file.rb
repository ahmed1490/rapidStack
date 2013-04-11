#require 'carrierwave/orm/activerecord'

class RapidFile < ActiveRecord::Base
	attr_accessible :filename, :filepath, :public

	#belongs_to :user
	has_many :user_files
	has_many :users, :through => :user_files

	validates_presence_of :filename



	mount_uploader :filename, RapidFileUploader
end
