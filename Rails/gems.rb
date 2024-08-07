                                       GEMS
                          
===> DEVISE :- (gem 'devise')
Devise is a flexible authentication solution for Rails based on Warden. 
It:
* Is Rack based;
* Is a complete MVC solution based on Rails engines;
* Allows you to have multiple models signed in at the same time;
* Is based on a modularity concept: use only what you really need.


Its composed of 10 modules:
* Database Authenticatable 
    -> hashes and stores a password in the database to validate the authenticity of a user while signing in. 
    -> The authentication can be done both through POST requests or HTTP Basic Authentication.
* Confirmable: 
    -> sends emails with confirmation instructions and verifies whether an account is already confirmed during sign in.
* Recoverable: 
    -> resets the user password and sends reset instructions.
* Registerable:
    -> handles signing up users through a registration process, also allowing them to edit and destroy their account.
* Rememberable: 
    -> manages generating and clearing a token for remembering the user from a saved cookie.
* Trackable: 
    -> tracks sign in count, timestamps and IP address.
* Timeoutable: 
    -> expires sessions that have not been active in a specified period of time.
* Validatable: 
    -> provides validations of email and password. 
    ->It's optional and can be customized, so you're able to define your own validations.
* Lockable:
    -> locks an account after a specified number of failed sign-in attempts. Can unlock via email or after a specified time period.
* Omniauthable: 
    -> adds OmniAuth (https://github.com/omniauth/omniauth) support.


INSTALLATION:-
1) bundle add devise
2) rails generate devise:install
3) config.action_mailer.default_url_options = { host: 'localhost', port: 3000 }                   => (config/environments/development.rb)
4) rails generate devise <model_name>
5) rails db:migrate
6) rails generate devise:views <model_name>                  => (set config.scoped_views = true inside the config/initializers/devise.rb)




===> DEVISE-INVITABLE :- (gem 'devise_invitable')
It adds support for send invitations by email (it requires to be authenticated) and accept the invitation by setting a password.

INSTALLATIONL:-
1) bundle add devise_invitable
2) rails generate devise_invitable:install
3) rails generate devise_invitable <model_name>             (if not created devise)
4) adding column using migration in model_name
		def change
			add_column :users, :invitation_token, :string
			add_column :users, :invitation_created_at, :datetime
			add_column :users, :invitation_sent_at, :datetime
			add_column :users, :invitation_accepted_at, :datetime
			add_column :users, :invitation_limit, :integer
			add_column :users, :invited_by_id, :integer
			add_column :users, :invited_by_type, :string
			add_index :users, :invitation_token, unique: true
		end
5) rails db:migrate
6) rails generate devise_invitable:views <model_name>                     => set config.scoped_views = true



To add a custom parameter or field 
1) rails generate migration add_name_to_users name:string
2) rails db:migrate
3) In model add validation if required
4) In application_controller.rb
			class ApplicationController < ActionController::Base
				before_action :configure_permitted_parameters, if: :devise_controller?

				protected

				def configure_permitted_parameters
					devise_parameter_sanitizer.permit(:sign_up, keys: [:name])
					devise_parameter_sanitizer.permit(:account_update, keys: [:name])
					devise_parameter_sanitizer.permit(:invite, keys: [:name])
				end
			end
5) Add the new field in forms you want.




====> ACTIVE STORAGE :- (gem 'image_processing')
* Active Storage facilitates uploading files to a cloud storage service like Amazon S3, Google Cloud Storage, 
	or Microsoft Azure Storage and attaching those files to Active Record objects. 
* It comes with a local disk-based service for development and testing and supports mirroring files to subordinate 
	services for backups and migrations.
* Using Active Storage, an application can transform image uploads or generate image representations of non-image 
	uploads like PDFs and videos, and extract metadata from arbitrary files.

Requirements:-
* libvips v8.6+ or ImageMagick for image analysis and transformations
* ffmpeg v3.4+ for video previews and ffprobe for video/audio analysis
* poppler or muPDF for PDF previews

Installation:-
1) bundle add image_processing
2) rails active_storage:install
3) rails db:migrate
4) config.active_storage.service = :local              # Store files locally.
	 config.active_storage.service = :amazon						 # Store files in Amazon S3.
	 config.active_storage.service = :test    					 # Store uploaded files on the local file system in a temporary directory.
5) Declare a Disk service in config/storage.yml:-
		local:																
	 		service: Disk
	 		root: <%= Rails.root.join("storage") %>		
6) has_one_attached :avatar		
7)  <div class="form-group">                          # form to upload attachment
      <%= f.label :avatar , "Profile Picture" %><br />
      <%= f.file_field :avatar %>
    </div>		
7) <%= image_tag rails_storage_proxy_path(current_user.avatar)%>      #display attached profile picture

