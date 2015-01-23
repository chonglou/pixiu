module NoticesHelper
  def latest_notice
    Notice.where(lang:params[:locale]).order(updated_at: :desc).first
  end
end