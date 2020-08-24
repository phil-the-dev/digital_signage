require "application_system_test_case"

class PlaylistPlayablesTest < ApplicationSystemTestCase
  setup do
    @playlist_playable = playlist_playables(:one)
  end

  test "visiting the index" do
    visit playlist_playables_url
    assert_selector "h1", text: "Playlist Playables"
  end

  test "creating a Playlist playable" do
    visit playlist_playables_url
    click_on "New Playlist Playable"

    fill_in "Order", with: @playlist_playable.order
    fill_in "Playable", with: @playlist_playable.playable_id
    fill_in "Playlist", with: @playlist_playable.playlist_id
    click_on "Create Playlist playable"

    assert_text "Playlist playable was successfully created"
    click_on "Back"
  end

  test "updating a Playlist playable" do
    visit playlist_playables_url
    click_on "Edit", match: :first

    fill_in "Order", with: @playlist_playable.order
    fill_in "Playable", with: @playlist_playable.playable_id
    fill_in "Playlist", with: @playlist_playable.playlist_id
    click_on "Update Playlist playable"

    assert_text "Playlist playable was successfully updated"
    click_on "Back"
  end

  test "destroying a Playlist playable" do
    visit playlist_playables_url
    page.accept_confirm do
      click_on "Destroy", match: :first
    end

    assert_text "Playlist playable was successfully destroyed"
  end
end
