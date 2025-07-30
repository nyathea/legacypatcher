## Repo Archived
While it still works and can be used no more updates will be made to this repo. TwitterLegacyPatcher will be integrated in our BHTwitter fork used for NeoFreeBird in the coming months. to become the "ultimate" tweak for twitter

# TwitterLegacyPatcher

A tweak to restore functionality to older Twitter versions for iOS/iPadOS 

This effectively makes it possible to use Twitter again on devices where it was broken previously.

## Patches include
- Bypassing certificate pinning in the app to fix sign in
- Spoofing the app version to bypass update now messages
- Fix problems with images not being displaed correctly by replacing `pic.x.com` with `pic.twitter.com`
- Patches out the now deprecated 1.1 endpoints to return the newer graphql ones.

It also includes several QoL improvements such as:
- Hides the (now useless) Fleets bar on versions that had it
- Removes all ads
- Enables Birdwatch (Community Notes) on supported versions

## Supported Versions

Every 7.x, 8.x, and 9.x version *should* work. it will not work on 6.x and below as much more is broken. this tweak isn't neccesary for 9.44+

## Nightly builds
If you wanna test the newest nightly builds, you can by visiting the link below. keep in mind things can and will break. please report any issues you find.

`rootful-build` is for devices on iOS 14 and below

`rootless-build` is for devices on iOS 15 and above

[Link to Nightly Build](https://nightly.link/nyathea/LegacyBird/workflows/makefile/main)

## Known Issues

- On some 8.x versions, attempting to log in will freeze the app and eventually cause an crash. A workaround is to log in using 7.29.1 first, then upgrade to your preferred version.
- The Search page and Quote tweets doesnt work
- You may not be able to like tweets or view peofiles on some versions because of deprecated endpoints. (this will be fixed soon)
- Banners disappear or dont show up at all
- latest (following) timeline doesnt work yet

Please let me know if theres any other issues! pleae open a bug report and i'll get to you as soon as i can
