require_relative '../providers/report_provider.rb'

class PlansController < ApplicationController
  def index
    @plans = Plan.where(user_id: current_user.id).order('since_date')
  end

  def create
    @plans = Plan.where(user_id: current_user.id).order('since_date')
    @plan = Plan.new(plan_params)
    @plan.user_id = current_user.id

    if @plan.save
      ReportProvider.check_plans(current_user.id)
      flash[:notice] = 'Plan added'
      redirect_to action: 'index'
    else
      flash[:notice] = 'Plan adding failed'
      render action: 'index'
    end
  end

  def edit
    @plan = Plan.where(user_id: current_user.id).find(params[:id])
  end

  def update
    @plan = Plan.where(user_id: current_user.id).find(params[:id])
    if @plan.update(plan_params.merge(reported: false))
      ReportProvider.check_plans(current_user.id)
      flash[:notice] = 'Plan updated'
      redirect_to action: 'index'
    else
      flash[:notice] = 'Plan updating failed'
      render action: 'edit'
    end
  end

  def destroy
    @plan = Plan.where(user_id: current_user.id).find(params[:id])
    @plan.destroy
    redirect_to plans_path
  end

  def plan_params
    params.require(:plan).permit(:title, :goal, :since_date, :to_date)
  end
end
