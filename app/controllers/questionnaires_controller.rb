class QuestionnairesController < ApplicationController
  def index
    token = SecureRandom.base58
    session[:questionnaire_token] = token
    redirect_to questionnaire_path(id: token)
  end

  def show
    # do something
  end
end
