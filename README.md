# TwitterLegacyPatcher

A tweak to restore functionality to older Twitter versions for iOS/iPadOS.

## What does this do?

**TwitterLegacyPatcher** works by:
- Disabling SSL pinning in the Twitter app
- Spoofing the app version to bypass the "Update your app" page on startup
- Fixing images now showing up correctly by replacing `pic.x.com` with `pic.twitter.com`
- Patches out the now deprecated 1.1 endpoints to make them redirect to the newer graphql endpoints used in newer versions

It also includes several QoL improvements such as:
- Hides the (now useless) Fleets bar on versions that have it
- Removes all ads
- Hides the "Discover More" section under tweets
- Enables Birdwatch (Community Notes) on supported versions

## Planned Improvements

- Fixing banner images not being displaying on profiles
- Fix viewing quote tweets on tweets
- Stop source labels from disappearing once the tweet has loaded
- Fix liking tweets and viewing profiles on 7.x versions

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

- On 8.58 (and likely other versions), logging in will crash the app or fail to authenticate. A workaround is to log in using 7.29.1 first, then upgrade to your preferred version. later 8.x versions dont seem to have this issue.
- Explore page and Search page doesnt work
- You may not be able to like tweets on some versions because of the client using deprecated endpoints. (this will be fixed soon)
- your profile may not load on the first launch. you may need to reopen it for it to work.

Please let me know if theres any other issues! pleae open a bug report and i'll get to you as soon as i can
