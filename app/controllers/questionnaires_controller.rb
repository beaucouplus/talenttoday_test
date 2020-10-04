class QuestionnairesController < ApplicationController
  def index
    token = SecureRandom.base58
    session[:questionnaire_token] = token
    redirect_to questionnaire_path(id: token)
  end

  def show
    @questionnaire = QuestionnaireForm.new
  end

  def create
    @questionnaire = QuestionnaireForm.new({ token: session[:questionnaire_token] }.merge(questionnaire_params))

    if @questionnaire.save
      redirect_to score_path(id: @questionnaire.token)
    else
      redirect_to questionnaires_path
    end
  end

  def questionnaire_params
    params.require(:questionnaire_form).permit(answers: {})
  end
end
