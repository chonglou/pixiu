class PersonalController < ApplicationController
  layout 'dashboard'
  before_action :authenticate_user!

  def contact
    case request.method
      when 'POST'
        @contact = current_user.contact
        if @contact
          @contact.update _contact_params
        else
          @contact=Contact.new _contact_params
          @contact.user_id = current_user.id
          @contact.save
        end
        render 'contact'
      when 'GET'
        @contact = current_user.contact || Contact.new
      else
    end
  end

  private
  def _contact_params
    params.require(:contact).permit(:email, :qq,:wechat,:fax,:phone,:skype,:address,:details)
  end
end
