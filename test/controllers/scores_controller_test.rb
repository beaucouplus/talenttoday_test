class ScoresControllerTest < ActionController::TestCase
  test 'get show' do
    get :show, params: {id: 'abcd'}
    assert_response :success
  end
end
