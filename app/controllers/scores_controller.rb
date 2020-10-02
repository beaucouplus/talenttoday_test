class ScoresController < ApplicationController
  def show
    @scores = Answer.scores_for(questionnaire_token: session[:questionnaire_token])
  end
end
