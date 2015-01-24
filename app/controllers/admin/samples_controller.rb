class Admin::SamplesController < Admin::ProductController
  before_action :_fetch_product

  def logo
    Sample.where(product_id:params[:product_id]).update_all(logo:false)
    Sample.where(product_id:params[:product_id], id:params[:sample_id]).update_all(logo:true)
    redirect_to admin_product_samples_path
  end

  def new
    @sample = Sample.new
  end

  def create
    @sample= Sample.new _sample_params

    file = params[:sample][:attachment]
    unless file
      flash[:alert] = t('labels.input_not_valid')
      render 'new' and return
    end
    attach = Attachment.new user_id: current_user.id
    attach.read! file
    attach.save!
    @sample.attachment_id = attach.id
    @sample.product_id = @product.id
    if @sample.save
      redirect_to admin_product_samples_path
    else
      render 'new'
    end
  end

  def edit
    @sample = Sample.find params[:id]
  end

  def update
    @sample = Sample.find params[:id]
    if @sample.update(_sample_params)
      redirect_to admin_product_samples_path
    else
      render 'edit'
    end
  end

  def destroy
    Sample.destroy params[:id]
    redirect_to admin_product_samples_path
  end

  private
  def _sample_params
    params.require(:sample).permit(:title, :summary)
  end
end
