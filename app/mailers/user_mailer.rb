class UserMailer < ApplicationMailer
    default from: 'timework.bibo@gmail.com'
    def welcome_email(user)
        @user = user.email
        mail(to: @user, subject: "Thank you for signing up")
    end

end
