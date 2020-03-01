import consumer from "./consumer" 

document.addEventListener("turbolinks:load", function() {
  const kiosk_code = document.getElementById("kiosk-code")

  consumer.subscriptions.create(
    { channel: "UserKioskChannel", kiosk_code: kiosk_code.innerText }, {
    action: { link: 'link' },

    received(data) {
      console.log(data)
      if(data.action = this.action.link){
        window.location = data.kiosk_path
      }
    },

    // Called once when the subscription is created.
    initialized() {
      this.update = this.update.bind(this)
    },

    // Called when the subscription is ready for use on the server.
    connected() {
      setTimeout(function () {

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
    },

    install() {
    },

    uninstall() {
    },
  })
})