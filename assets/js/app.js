// If you want to use Phoenix channels, run `mix help phx.gen.channel`
// to get started and then uncomment the line below.
// import "./user_socket.js"

// You can include dependencies in two ways.
//
// The simplest option is to put them in assets/vendor and
// import them using relative paths:
//
//     import "../vendor/some-package.js"
//
// Alternatively, you can `npm install some-package --prefix assets` and import
// them using a path starting with the package name:
//
//     import "some-package"
//

// Include phoenix_html to handle method=PUT/DELETE in forms and buttons.
import "phoenix_html"
// Establish Phoenix Socket and LiveView configuration.
import {Socket} from "phoenix"
import {LiveSocket} from "phoenix_live_view"
import shootConfetti from "./app/confetti.js"
import {darkExpected, initDarkMode} from "./app/darkmode.js"

window.addEventListener("phx:request_received", (_e) => {
  shootConfetti();
});

// Copy to clipboard
window.addEventListener("wexhook:clipcopy_hook_url", (_e) => {
  document.getElementById('hook-url').select();
  document.execCommand('copy');
});

window.addEventListener("wexhook:clipcopy_share_url", (_e) => {
  document.getElementById('share-url').classList.remove('hidden');
  document.getElementById('share-url').select();
  document.execCommand('copy');
  document.getElementById('share-url').classList.add('hidden');
});

// Dark mode handling
window.addEventListener("toogle-darkmode", (_e) => {
  if (darkExpected()) localStorage.theme = 'light';
  else localStorage.theme = 'dark';
  initDarkMode();
})

initDarkMode();

let csrfToken = document.querySelector("meta[name='csrf-token']").getAttribute("content")
let liveSocket = new LiveSocket("/wexhook/live", Socket, {params: {_csrf_token: csrfToken}})

// connect if there are any LiveViews on the page
liveSocket.connect()

// expose liveSocket on window for web console debug logs and latency simulation:
// >> liveSocket.enableDebug()
// >> liveSocket.enableLatencySim(1000)  // enabled for duration of browser session
// >> liveSocket.disableLatencySim()
window.liveSocket = liveSocket

