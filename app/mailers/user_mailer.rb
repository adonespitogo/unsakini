class UserMailer < ActionMailer::Base
  default from: 'notifications@example.com'

  def confirm_account(user)
    @user = user
    @url  = "#{root_url}api/user/confirm/#{@user.confirmation_token}"
    mail(to: @user.email, subject: 'Unsakini - Account Confirmation')
  end

end
