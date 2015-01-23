class Admin::SamplesController < Admin::ProductController
  before_action :_fetch_product

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
    attach.content_type = file.content_type
    attach.title = file.original_filename
    attach.ext = file_ext file.original_filename
    attach.avatar = file
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
