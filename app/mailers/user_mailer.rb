class UserMailer < ApplicationMailer
    default from: 'mailer@example.com'
    def welcome_email(user)
        @user = user.email
        mail(to: @user, subject: "Thank you for signing up")
    end

end
