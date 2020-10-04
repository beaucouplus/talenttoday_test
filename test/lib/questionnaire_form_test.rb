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

  test 'is not valid when missing answer' do
    questionnaire_token = 'abcde'
    answers = { '0' => 'THOROUGHNESS', '1' => 'AMBITION', '2' => 'THOROUGHNESS', '3' => 'AMBITION', '4' => 'PATIENCE' }

    questionnaire = QuestionnaireForm.new(token: questionnaire_token, answers: answers)
    assert_equal false, questionnaire.save
  end

  test 'is not valid when missing token' do
    questionnaire_token = nil
    answers = { '0' => 'THOROUGHNESS', '1' => 'AMBITION', '2' => 'THOROUGHNESS', '3' => 'AMBITION', '4' => 'PATIENCE', '5' => 'PATIENCE' }

    questionnaire = QuestionnaireForm.new(token: questionnaire_token, answers: answers)
    assert_equal false, questionnaire.save
  end

  test 'is not valid when at least one answer is invalid' do
    questionnaire_token = 'abcd'
    answers = { '0' => 'THOROUGHNESS', '1' => 'AMBITION', '2' => 'THOROUGHNESS', '3' => 'AMBITION', '4' => 'PATIENCE', '5' => 'dumbness' }

    questionnaire = QuestionnaireForm.new(token: questionnaire_token, answers: answers)
    assert_equal false, questionnaire.save
  end
end
