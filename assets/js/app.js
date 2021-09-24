// We need to import the CSS so that webpack will load it.
// The MiniCssExtractPlugin is used to separate it out into
// its own CSS file.
import "../css/app.scss"

// webpack automatically bundles all modules in your
// entry points. Those entry points can be configured
// in "webpack.config.js".
//
// Import deps with the dep name or local files with a relative path, for example:
//
//     import {Socket} from "phoenix"
//     import socket from "./socket"
//
import "phoenix_html"
import {Socket} from "phoenix"
import topbar from "topbar"
import {LiveSocket} from "phoenix_live_view"
import dragula from "dragula"


dragula(Array.from(document.querySelectorAll('.column')))
  .on('drop', (element, target) => {

    let card_ids = [];
    for (let item of target.children) {
      card_ids.push(item.dataset.cardId);
    }

    fetch('/api/cards/' + element.dataset.cardId, {
      method: 'PUT',
      headers: {
        'Content-Type': 'application/json'
      },
      body: JSON.stringify({
        target_column_id: target.dataset.columnId,
        column_sort_order: card_ids,
      })
    }).then(_res => console.log(_res))
  });




let Hooks = {}
Hooks.ContentEditable = {
  mounted(){
    this.el.addEventListener("focusout", e => {
      let payload = {}
      payload[this.el.dataset.type] = this.el.dataset[this.el.dataset.type]
      payload['value'] = this.el.innerText

      if (this.el.dataset.type === 'card') {
        this.pushEvent("update_card", payload)
      }

      if (this.el.dataset.type === 'column') {
        this.pushEvent("update_column", payload)
      }
    })
  }
}

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/live", Socket, {params: {_csrf_token: csrfToken}, hooks: Hooks})

// Show progress bar on live navigation and form submits
topbar.config({barColors: {0: "#29d"}, shadowColor: "rgba(0, 0, 0, .3)"})
window.addEventListener("phx:page-loading-start", info => topbar.show())
window.addEventListener("phx:page-loading-stop", info => topbar.hide())

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket