import consumer from "./consumer"

// Select the node that will be observed for mutations
// const targetNode = document.getElementById('some-id');

// // Options for the observer (which mutations to observe)
// const config = { attributes: true, childList: true, subtree: true };

// // Callback function to execute when mutations are observed
// const callback = function(mutationsList, observer) {
//     // Use traditional 'for loops' for IE 11
//     for(let mutation of mutationsList) {
//         if (mutation.type === 'childList') {
//             console.log('A child node has been added or removed.');
//         }
//         else if (mutation.type === 'attributes') {
//             console.log('The ' + mutation.attributeName + ' attribute was modified.');
//         }
//     }
// };

// // Create an observer instance linked to the callback function
// const observer = new MutationObserver(callback);

// // Start observing the target node for configured mutations
// observer.observe(targetNode, config);

consumer.subscriptions.create(
  { channel: "KioskChannel", room: 1 }, {

  player: undefined,
  button: undefined,
  fetchPlayer() { return document.getElementById('main-player') },
  fetchButton() { return document.getElementById('kiosk-1') },

  received(data) {
    console.log(data)
    if (this.player != null) {
      console.log('player action')
      if (data.action == "paused") {
        console.log("player pausing")
        this.player.pause();
      } else if (data.action == "play") {
        console.log("player playing")
        this.player.play();
      }
    } else if (this.button != null) {
      if (data.action == "paused") {
        console.log('here')
        this.button.innerText = "Play"
      } else if (data.action == "play") {
        console.log('here2')
        this.button.innerText = "Pause"
      }
    }
  },

  // Called once when the subscription is created.
  initialized() {
    this.update = this.update.bind(this)
  },

  // Called when the subscription is ready for use on the server.
  connected() {
    setTimeout(function () {
      this.player = this.fetchPlayer();
      this.button = this.fetchButton();

      this.install()
      this.update()
    }.bind(this), 1000)

  },

  // Called when the WebSocket connection is closed.
  disconnected() {
    this.uninstall()
  },

  // Called when the subscription is rejected by the server.
  rejected() {
    this.uninstall()
  },

  update() {
    if (this.player != null) {
      !this.player.paused ? this.play() : this.pause()
    }
  },

  play() {
    this.perform("playing", { kiosk: 1 })
    if (this.button != null)
      this.button.innerText = "Pause"
  },

  pause() {
    this.perform("paused", { kiosk: 1 })
    if (this.button != null)
      this.button.innerText = "Play"
  },

  install() {
    if (this.player != null) {
      this.player.onpause = this.update
      this.player.onplay = this.update
    } else if (this.button != null) {
      this.button.onclick = function (e) {
        if (e.target.innerText === "Play") {
          this.perform("play", { kiosk: 1, source: 'button' })
        } else {
          this.perform("paused", { kiosk: 1, source: 'button' })
        }
      }.bind(this)
    }
  },

  uninstall() {
    this.player.removeEventListener("playing", this.update)
    this.player.removeEventListener("pause", this.update)
  },

  get isVideoPlaying() {
    return this.player ? !this.player.paused : false;
  },
})
