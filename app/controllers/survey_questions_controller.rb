class SurveyQuestionsController < ApplicationController
  before_action :find_survey, only: [:create, :update, :destroy]
  before_action :find_survey_question, only: [:update, :destroy]

  # survey question create
  def create
    @survey_question = @survey.survey_questions.new(survey_params)
    if @survey_question.save
      render json: @survey_question, status: :created
    else
      render json: @survey_question.errors, status: :unprocessable_entity
    end
  end

  # survey question update
  def update
    if @survey_question.update(survey_params)
      render json: @survey_question
    else
      render json: @survey_question.errors, status: :unprocessable_entity
    end
  end

  # survey question destory
  def destroy
    if @survey_question.destroy
      render json: { message: 'Survey question deleted successfully' }, status: :ok
    else
      render json: { error: 'Failed to delete survey question' }, status: :unprocessable_entity
    end
  end

  private

  def find_survey
    @survey = Survey.find(params[:survey_id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Survey not found' }, status: :not_found
  end

  def find_survey_question
    @survey_question = @survey.survey_questions.find(params[:id])
  rescue ActiveRecord::RecordNotFound
    render json: { error: 'Survey question not found' }, status: :not_found
  end

  def survey_params
    params.permit(:id, :label, :inputs, :survey_id)
  end
end
