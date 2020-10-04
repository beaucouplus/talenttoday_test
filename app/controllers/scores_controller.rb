class ScoresController < ApplicationController
  def show
    @scores = Answer.scores_for(questionnaire_token: params[:id])
  end
end
