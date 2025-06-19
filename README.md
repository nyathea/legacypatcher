# TwitterLegacyPatcher

A tweak to restore functionality to older Twitter versions for iOS/iPadOS.

## Overview

**TwitterLegacyPatcher** works by:
- Disabling SSL pinning in the Twitter app
- Spoofing the app version to bypass the "Update your app" page on startup
- Fixing images by replacing `pic.x.com` links with `pic.twitter.com`.

It also includes several QoL improvements such as:
- Removes the (now useless) Fleets bar on versions that have it
- Disables ads
- Removes "Discover More" section under tweets
- Enables Birdwatch (Community Notes) on supported versions

### Planned Improvements

- Fixing banner images not being displaying on profiles
- Fix viewing quote tweets on tweets
- Fix tweet translation errors
- Stop source labels from disappearing once the tweet has loaded

## Tested Versions

- v7.29.1
- v8.58
- v8.71
- v9.10.1

## Known Issues

- **Login Issues:**  
  On v8.58 (and likely other 8.x versions), logging in may crash the app or fail outright. A workaround is to log in using v7.29.1 first, then upgrade to your preferred version.
- **Feature Limitations on 8.58/8.71:**  
  - Video playback is inconsistent.
  - Viewing quote tweets, banner images, Explore/Search, and translating tweets may not work.
  - On some versions, liking tweets fails because of deprecated endpoints.

---

**Note:** This project is a work in progress. Contributions and issue reports are welcome!
