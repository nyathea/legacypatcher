# TwitterLegacyPatcher&nbsp;<img src="https://upload.wikimedia.org/wikipedia/commons/6/6f/Logo_of_Twitter.svg" alt="Twitter" height="25"/>

A tweak to restore functionality to older Twitter versions for iOS/iPadOS. 

This effectively makes it possible to use Twitter again on devices where it was broken previously.

## What does this do?

**TwitterLegacyPatcher** works by:
- Bypassing certificate pinning in the app
- Spoofing the app version to bypass update nags
- Fixes issues with images not being displaying correctly by replacing `pic.x.com` with `pic.twitter.com` in links
- Patches out the now deprecated 1.1 endpoints and return the newer graphql endpoints

It also includes several QoL improvements such as:
- Hides the (now useless) Fleets bar on versions that have it
- Removes all ads
- Hides the "Discover More" section under tweets
- Enables Birdwatch (Community Notes) on supported versions

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

- On versions below 8.71(?), attempting to log in will crash the app. A workaround is to log in using 7.29.1 first, then upgrade to your preferred version.
- The Search page and Quote tweets doesnt work
- You may not be able to like tweets on some versions because of the client using deprecated endpoints. (this will be fixed soon)
- Banners and Source labels disappear or dont appear at all once the view is refreshed
- latest (following) timeline doesnt work yet

Please let me know if theres any other issues! pleae open a bug report and i'll get to you as soon as i can
