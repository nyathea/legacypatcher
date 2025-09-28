# TwitterLegacyPatcher

A tweak to restore functionality to older Twitter versions for iOS/iPadOS 9+

This makes it possible to use Twitter again on devices where it was broken previously.

## Patches include
- Bypass certificate pinning in the app
- Spoofing app version
- Fix problems with images not being displaed correctly by replacing `pic.x.com` with `pic.twitter.com`

It also includes several QoL improvements such as:
- Hides the (now useless) Fleets bar on versions that had it
- Removes all ads
- Enables Birdwatch (Community Notes) on supported versions

## Supported Versions

7.x, 8.x, and 9.x versions *should* work. it will not work on 6.x or below

## Nightly builds
If you wanna test the newest nightly builds, you can by visiting the link below. keep in mind things can and will break.

`rootful-build` is for devices on iOS 14 and below

`rootless-build` is for devices on iOS 15 and above

[Link to Nightly Build](https://nightly.link/NeoFreeBird/LegacyPatcher/workflows/makefile/main)

## Known Issues

- On some 8.x versions, attempting to log in will freeze the app and eventually cause an crash. A workaround is to log in using 7.29.1 first, then upgrade to your preferred version.
- The Search page and Quote tweets dont work
- You may not be able to like tweets or view peofiles on some versions
- Banners dont show up at all
- latest (following) timeline doesnt work yet

## Log in workaround
If you get a (not found) error after attempting to log in you must press on "forgot password" and check your email for the code from Twitter. when you reset you can use your current password as it doesnt matter. after this you will get a blue "Return to X" button. after pressing this you will be logged into your account. effectivly bypassing the broken login.
