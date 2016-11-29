class Unsakini::UserMailer < ActionMailer::Base
    default from: 'notifications@example.com'

    def confirm_account(user)
      @token = user.confirmation_token
      mail(to: user.email, subject: 'Unsakini - Account Confirmation')
    end
end
