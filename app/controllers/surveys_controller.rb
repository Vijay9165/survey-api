class SurveysController < ApplicationController
  before_action :find_survey, only: [:show]
  def create
    @survey = Survey.new(survey_params)
    if @survey.save
      render json: @survey, status: :created
    else
      render json: @survey.errors, status: :unprocessable_entity
    end
  end

  def show
    render json: @survey.survey_questions
  end

  private

  def find_survey
    @survey = Survey.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Survey not found' }, status: :not_found
  end

  def survey_params
    params.permit(:id, :name, :description)
  end
end
