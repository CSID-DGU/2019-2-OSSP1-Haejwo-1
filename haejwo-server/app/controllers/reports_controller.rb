class ReportsController < ApplicationController
  def new
    @report = Report.new
  end

  def create
    @report.save
  end
end
