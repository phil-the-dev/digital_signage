// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

require("@rails/activestorage").start()
require("channels")

// Uncomment to copy all static images under ../images to the output folder and reference
// them with the image_pack_tag helper in views (e.g <%= image_pack_tag 'rails.png' %>)
// or the `imagePath` JavaScript helper below.
//
// const images = require.context('../images', true)
// const imagePath = (name) => images(name, true)
document.onreadystatechange = function () {
  if (document.readyState == "interactive") {
    obj = new Player('main-player');
  }
}

function Player(elementId) {
  obj = {
    player: document.getElementById(elementId),
    reloadPending: false,

    get position() { return parseInt(this.player.dataset.currentPosition) },
    get playlist() { return JSON.parse(this.player.dataset.playlist) },

    set position(new_position) { this.player.dataset.currentPosition = parseInt(new_position) },
    set playlist(new_playlist) { this.player.dataset.playlist = new_playlist },

    get endOfPlaylist() { return this.position == this.playlist.length - 1 },
    get currentVideo() { return this.playlist[this.position] },

    moveToNextVideo: function () {
      if (this.reloadPending) {
        location.reload();
      } else {
        this.position += 1;
        this.player.src = this.playlist[this.position].file;
        this.player.play();
        if (this.endOfPlaylist) {
          this.restartPlaylist();
        }
      }
    },

    restartPlaylist: function () {
      response = this.ableToGetMore()
      if (response == "NO-CONTENT") {
        console.debug("unable to reach server, looping back...");
        this.position = -1;
      } else {
        console.debug("reached server!");
        if (response == "REFRESH") {
          console.debug("got reload command, will reload");
          this.reloadPending = true;
        } else {
          console.debug("got new playlist");
          new_playlist = JSON.parse(response)
          this.playlist = JSON.stringify([this.currentVideo].concat(new_playlist));
          this.position = 0;
        }
      }
    },

    ableToGetMore: function () {
      var uri = window.location + ".json"
      var xhr = new XMLHttpRequest();
      xhr.open("GET", uri, false);
      xhr.send(null);
      if (xhr.status == 200) {
        //is online
        return xhr.responseText;
      }
      else {
        //is offline
        return "NO-CONTENT";
      }
    }
  }

  obj.player.addEventListener("ended", function () {
    obj.moveToNextVideo()
  }.bind(this));

  return obj;
}

