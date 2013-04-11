#require 'digest/sha1'

class User < ActiveRecord::Base
	
	has_many :user_files
	has_many :rapid_files, :through => :user_files

	EMAIL_REGEX = /^[A-Z0-9._%+-]+@[A-Z0-9.-]+\.[A-Z]{2,4}$/i

	validates_presence_of :name, :email, :password
	validates_length_of :name, :within => 3..255
	validates_length_of :password, :minimum => 7
	validates_format_of :email, :with => EMAIL_REGEX
	validates_uniqueness_of :email, 
						:message => " is already registered!"
	#validates_inclusion_of :usertype, :in => [0,1]

	#has_many :uploaded_files, through => :user_files, :class_name => "RapidFile", :foreign_key => 'owner_id'
	#has_many :uploaded_files,  :class_name => :RapidFile, :conditions => "uploadedBy = "

	#def self.hash(password="")
	#	Digest::SHA1.hexdigest(password)
	#end

	def self.authenticate(username="", password="")
		user = User.where(:email => username, :password => password )
		if user.size > 0
			return user[0]
		else
			return false
		end
	end

end