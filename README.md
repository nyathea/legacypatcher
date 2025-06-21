# TwitterLegacyPatcher

A tweak to restore functionality to older Twitter versions for iOS/iPadOS.

## What does this do?

**TwitterLegacyPatcher** works by:
- Disabling SSL pinning in the Twitter app
- Spoofing the app version to bypass the "Update your app" page on startup
- Fixing images by replacing `pic.x.com` links with `pic.twitter.com`.

It also includes several QoL improvements such as:
- Removes the (now useless) Fleets bar on versions that have it
- Disables ads
- Removes "Discover More" section under tweets
- Enables Birdwatch (Community Notes) on supported versions

## Planned Improvements

- Fixing banner images not being displaying on profiles
- Fix viewing quote tweets on tweets
- Stop source labels from disappearing once the tweet has loaded

## Tested Versions

- v7.29.1
- v8.58
- v8.71
- v9.10.1

## Where do i download?
Right now releases wont be made until its stable, if you want to test it you can download from the nightly link or from the workflow.

`rootful-build` is for devices on iOS 14 and below

`rootless-build` is for devices on iOS 15 and above

[Link to Nightly Build](https://nightly.link/nyathea/TwitterLegacyPatcher/workflows/makefile/main)

## Known Issues

- On 8.58 (and likely other versions), logging in will crash the app or fail to authenticate. A workaround is to log in using 7.29.1 first, then upgrade to your preferred version.
- Explore page and Search page doesnt work
- You may not be able to like tweets on some versions because of it using deprecated endpoints.
- There may be random crashes in some places. please send crash logs.
- your profile may not load on some startups. you may need to reopen it for it to work.

Please let me know if theres any other issues! pleae open a bug report and i'll get to you as soon as i can
