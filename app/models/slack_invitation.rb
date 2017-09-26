require 'watir'
 
 module SlackInvitation
   class Invitator
 
     attr_writer :team, :admin_email, :admin_password
 
     def initialize
       @driver = nil
       @headless = nil
     end
     
     def start
       @driver = Watir::Browser.new :chrome  
     end
 
     def quit
       @driver.quit
     end
 
     # def headless_start
     #   @headless = Headless.new
     #   @headless.start
     # end
     
     # def headless_destroy
     #   @headless.destroy
     # end
     
     def invite(email)
       login
       send_invitation_mail(email)
       # test_success
     end
 
     def config(team, email, password)
       @team = team
       @admin_email = email
       @admin_password = password
     end
 
     private
     
     def login
       @driver.goto slack_url
       @driver.text_field(:id => 'email').set (@admin_email)
       @driver.text_field(:id => 'password').set (@admin_password)
       @driver.button(:id, 'signin_btn').click
       true
     end
 
     def send_invitation_mail(email)
       return false if email !~ /@/
       
       tries ||= 
       wait tries
       # @driver.goto slack_url
       @driver.button(:id, "channel_list_invites_link").click  
       wait tries
       @driver.text_field(:name, 'email_address').set (email)
       @driver.button(:id, 'admin_invites_submit_btn').click
       wait tries
     end
 
     # def test_success
     #   error = @driver.find_element(:class, 'error_msg').displayed?
     #   success = @driver.find_element(:class, 'seafoam_green').displayed?
 
     #   return true if success
     #   return false if error
     # end
     
     def slack_url
       "http://#{ @team }.slack.com/"
     end
 
     # def invitation_url
     #   "https://#{ @team }.slack.com/"   
     # end
     
     def wait(try = nil)
       sleep(3) unless try
       sleep(0.5 + try*1) if try
     end
   end
 end