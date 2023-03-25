# Changelog

## Unreleased

### Added
- Add footer with github link

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
