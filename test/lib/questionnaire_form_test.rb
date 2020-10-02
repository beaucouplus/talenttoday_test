require 'test_helper'

class QuestionnaireFormTest < ActiveSupport::TestCase
  test 'can create answers' do
    questionnaire_token = 'abcde'
    answers = { '0' => 'THOROUGHNESS', '1' => 'AMBITION', '2' => 'THOROUGHNESS', '3' => 'AMBITION', '4' => 'PATIENCE', '5' => 'PATIENCE' }

    assert_difference 'Answer.count', 6, '6 records should be added' do
      questionnaire = QuestionnaireForm.new(token: questionnaire_token, answers: answers)
      assert_equal true, questionnaire.save
    end
  end
end
