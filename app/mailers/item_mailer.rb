class ItemMailer < ApplicationMailer

  def item_created
    @user = params[:user]
    @item = params[:item]
    
    mail(
      to: ENV['MAIL_TO'], 
      subject: 'New item created'
    )
  end

end
