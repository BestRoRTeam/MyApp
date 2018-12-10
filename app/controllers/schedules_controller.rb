class SchedulesController < ApplicationController
  def index; end

  def recurring_expenses
    @period = (params[:period] || ProductProvider.dates[0])
    @products = Product.where(user_id: current_user.id).order('created_at')
    @products = @products.where('created_at > ?', ProductProvider.date_selector(@period)) if @period != 'All'
    @choices = []
    Category.where(user_id: current_user.id).each do |c|
      @choices.push(c.name)
    end
    @choice = @choices.first
  end

  def destroy
    Product.delete_delay_job(params[:id], current_user.id)
    redirect_to schedules_list_path
  end

  def list
    @jobs = Delayed::Job.where('run_at >= NOW()')
                        .where('attempts = 0')
                        .where('locked_at IS NULL')
                        .where('locked_by IS NULL')
                        .where('failed_at IS NULL')
    result = []
    @jobs.each do |job|
      result.push(job.payload_object.args.unshift(job.id)) if job.payload_object.args[1] == current_user.id
    end
    @jobs = result
  end

  def create
    period = params[:period]
    date = params[:schedule][:date]
    new_params = params[:schedule]
    new_params.delete(:date)
    new_params[:category] = params[:category]
    params = new_params
    Product.delay(run_at: date).create_delay_job(params, current_user.id, period, date)
    flash[:notice] = 'Recurring expense added'
    redirect_to schedules_list_path
  end
end
