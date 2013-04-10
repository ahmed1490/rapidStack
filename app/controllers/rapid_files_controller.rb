class RapidFilesController < ApplicationController

	before_filter :confirm_logged_in

	def upload
		#render 'files/upload.html'
	end

	def uploader
		@rapid_file = RapidFile.new
	end

	def index
		@files = User.find(session[:user_id]).rapid_files
	end

	def create
		puts "tanaaa  "+params.inspect

		user = User.find(session[:user_id])
	    file = RapidFile.new(params[:rapid_file])
	    file.filepath = "public"+file.filename.url
	    file.public = ( params[:privacy]=="public" ? 1 : 0 )
	    
	    user_file = UserFile.new
	    user_file.user_id = user.id
	    user_file.rapid_file_id = file.id

	    file.user_files << user_file
	    file.save!

	    redirect_to "/upload_success", :filename => file.filename.identifier
	end

	def uploadFile
		if params[:upload] == nil || params[:upload] == ""
			flash[:error] = "Please select a file to upload!"
			redirect_to "/upload"
			return
		end	
		file_name , path = saveFileToDir params[:upload]

		puts "file_name is "+file_name
		puts "path is "+path

		user = User.find(session[:user_id])
	    file = RapidFile.create(	:filename => file_name, 
	    							:filepath => path, 
	    							:public => (params[:privacy]=="public" ? 1 : 0)
	    						) 
	    
	    user_file = UserFile.new
	    user_file.user_id = user.id
	    user_file.rapid_file_id = file.id

	    file.user_files << user_file

	    user_file.save

	    redirect_to "/upload_success", :filename => file_name
  	end

  	def saveFileToDir(upload)
  		filename =  upload.original_filename
	    directory = "public/data/"+Time.now.to_i.to_s

	    #Create dir if !exists
		FileUtils.mkdir_p(directory) unless File.directory?(directory)

	    path = File.join(directory, filename)
	    File.open(path, "wb") { |f| f.write(upload.read) }
	    return filename, path
  	end

  	def destroy
  		 file = RapidFile.find_by_id(params[:id])
		 user_file = UserFile.where( :user_id => session[:user_id], :rapid_file_id => file.id).first
		 user_file.delete
		 file.delete
		 flash[:notify] = "File Deleted Successfully!"
		 redirect_to "/files"
  	end
end
