# Changelog

## Unreleased

## 0.7.0 (2023-05-03)

### Changed
- Use of streams to store the requests in the LV

## 0.6.1 (2023-03-28)

### Fixed
- Static endpoint is now exposed under `/wexhook` to avoid issues under proxies

## 0.6.0 (2023-03-28)

### Added
- Add darkmode
- Isolate fly.io Dockerfile as it requires ipv6 that causes problems in other systems

## 0.5.0 (2023-03-26)

### Added
- Form to modify hook response

## 0.4.0 (2023-03-25)

### Added
- Add footer with github link
- Redesign of request data

## 0.3.1 (2023-03-25)

### Fixed
- We were using a wrong debian bullseye version that were not compatible with
  latests elixir/erlang versions

## 0.3.0 (2023-03-25)

### Added
- Upgrade elixir/erlang/dependencies

## 0.2.0 (2023-03-25)

### Added
- Enable home view on `/wexhook` URL
- Add fly.io link to the README.md
- Calculate URLs based on the `host_uri`

### Changed
- Added `/wexhook` prefix on `share` and `hook` URLs
- Change socket connection path from `/live` to `/wexhook/live`

## 0.1.0 (2023-03-24)

Initial version of the service

### Added
- Add `/hook/:id` endpoint for receiving webhook requests
- Add `/status` endpoint for health-checking
- Add `/metrics` endpoint for prometheus metrics reporting
- Display incoming webhook requests in web interface for inspection
- Copy and share buttons for new endpoints
