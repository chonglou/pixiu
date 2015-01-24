class PersonalController < ApplicationController
  layout 'dashboard'
  before_action :authenticate_user!

  def logo
    @contact = current_user.contact || Contact.create(user_id:current_user.id)

    case request.method
      when 'POST'
        iio = params[:logo]
        if iio && iio.content_type.start_with?('image')
          attach = Attachment.new user_id: current_user.id
          attach.read! iio
          attach.save

          @contact.update logo_id:attach.id
        else
          flash[:alert] = t('labels.input_not_valid')
        end
        redirect_to personal_logo_path
      else
    end
  end
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
