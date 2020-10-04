class QuestionnairesControllerTest < ActionController::TestCase
  test 'get index' do
    get :index
    assert_response :redirect
  end

  test 'post create with all params' do
    assert_difference 'Answer.count', 6, '6 records should be added' do
      post :create, params: { questionnaire_form: { answers: { '0' => 'THOROUGHNESS', '1' => 'AMBITION', '2' => 'THOROUGHNESS', '3' => 'AMBITION', '4' => 'PATIENCE', '5' => 'PATIENCE' } } }, session: { questionnaire_token: 'abcd' }
      assert_response :redirect
    end
  end

  test 'post create without token' do
    assert_no_difference 'Answer.count' do
      post :create, params: { questionnaire_form: { answers: { '0' => 'THOROUGHNESS', '1' => 'AMBITION', '2' => 'THOROUGHNESS', '3' => 'AMBITION', '4' => 'PATIENCE', '5' => 'PATIENCE' } } }, session: { questionnaire_token: nil }
      assert_response :redirect
    end
  end

  test 'post create without all answers' do
    assert_no_difference 'Answer.count' do
      post :create, params: { questionnaire_form: { answers: { '0' => 'THOROUGHNESS', '1' => 'AMBITION', '2' => 'THOROUGHNESS', '3' => 'AMBITION', '4' => 'PATIENCE' } } }, session: { questionnaire_token: "abcd" }
      assert_response :redirect
    end
  end
end
