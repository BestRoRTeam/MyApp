class ReportProvider
  class << self
    def check_plans(user_id)
      plans = Plan.where(user_id: user_id)
      plans.each do |plan|
        next unless (plan.status > plan.goal) && !plan.reported

        report = Report.new
        report.msg = 'You have exceeded the budget limit of "' + plan.title + '"'
        report.user_id = user_id
        report.save
        Plan.update(plan.id, reported: true)
      end
    end
  end
end
