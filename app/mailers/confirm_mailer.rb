class ConfirmMailer < ApplicationMailer
  def confirm_mail(post)
    @post = post

    mail to: post.user.email,
    subject: "投稿の確認メール"
  end
end
