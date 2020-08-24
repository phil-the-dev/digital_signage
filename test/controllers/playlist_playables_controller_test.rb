require 'test_helper'

class PlaylistPlayablesControllerTest < ActionDispatch::IntegrationTest
  setup do
    @playlist_playable = playlist_playables(:one)
  end

  test "should get index" do
    get playlist_playables_url
    assert_response :success
  end

  test "should get new" do
    get new_playlist_playable_url
    assert_response :success
  end

  test "should create playlist_playable" do
    assert_difference('PlaylistPlayable.count') do
      post playlist_playables_url, params: { playlist_playable: { order: @playlist_playable.order_number, playable_id: @playlist_playable.playable_id, playlist_id: @playlist_playable.playlist_id } }
    end

    assert_redirected_to playlist_playable_url(PlaylistPlayable.last)
  end

  test "should show playlist_playable" do
    get playlist_playable_url(@playlist_playable)
    assert_response :success
  end

  test "should get edit" do
    get edit_playlist_playable_url(@playlist_playable)
    assert_response :success
  end

    patch playlist_playable_url(@playlist_playable), params: { playlist_playable: { order: @playlist_playable.order_number, playable_id: @playlist_playable.playable_id, playlist_id: @playlist_playable.playlist_id } }
    assert_redirected_to playlist_playable_url(@playlist_playable)
  end

  test "should destroy playlist_playable" do
    assert_difference('PlaylistPlayable.count', -1) do
      delete playlist_playable_url(@playlist_playable)
    end

    assert_redirected_to playlist_playables_url
  end
end
