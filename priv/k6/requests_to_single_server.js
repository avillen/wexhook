import http from "k6/http";
import { check, sleep } from "k6";
import { htmlReport } from "https://raw.githubusercontent.com/benc-uk/k6-reporter/2.2.0/dist/bundle.js";

// See https://k6.io/docs/using-k6/options/#using-options for documentation on k6 options
export const options = {
  vus: 10,
  duration: '30s',
  thresholds: { // See https://k6.io/docs/using-k6/thresholds/
    http_req_failed: ['rate==0.00'],
    http_req_duration: ['max<120'],
    http_reqs: ['count>800'],
  }
};

const serverId = Math.random().toString(36).substring(7);

export default function () {
  // To set dynamic (e.g. environment-specific) configuration, pass it either as environment
  // variable when invoking k6 or by setting `:k6, env: [key: "value"]` in your `config.exs`,
  // and then access it from `__ENV`, e.g.: `const url = __ENV.url`

  let baseUrl = "http://localhost:4000";

  // See https://k6.io/docs/using-k6/protocols/http-2/ for documentation on k6 and HTTP
  let postWebhookUrl = `${baseUrl}/wexhook/hook/${serverId}`;

  let res = http.post(postWebhookUrl, {});
  check(res, { success: (r) => r.status === 200 });
  sleep(0.3);
}

export function handleSummary(data) {
  return {
    "summaries/requests_to_single_server.html": htmlReport(data),
  };
}
