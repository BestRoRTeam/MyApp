class PagesController < ApplicationController
  def delete_report
    report = Report.where(user_id: current_user.id).find(params[:id])
    report.delete
  end
end
