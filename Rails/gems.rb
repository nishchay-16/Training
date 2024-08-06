                                       GEMS
                          
1) DEVISE:- (gem 'devise')
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


