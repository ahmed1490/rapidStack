require 'digest/sha1'

class User < ActiveRecord::Base
	
	has_many :user_files
	has_many :rapid_files, :through => :user_files
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