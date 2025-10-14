# TwitterLegacyPatcher

A tweak to restore functionality to older Twitter versions for iOS/iPadOS 9+

This makes it possible to use Twitter again on devices where it was broken previously.

## Patches include
- Bypass certificate pinning in the app
- Spoofing app version
- Fix problems with images not being displaed correctly by replacing `pic.x.com` with `pic.twitter.com`

## Supported Versions

7.x, 8.x, and 9.x versions *should* work. it will not work on 6.x or below

## Known Issues

- On some 8.x versions, attempting to log in will freeze the app and eventually cause an crash. (A workaround is to log in using 7.29.1 first or a newwr version if possible)
- The Search page and Quote tweets dont work
- You may not be able to like tweets or view peofiles on some versions
- Banners dont show up at all
- latest (following) timeline doesnt work
- Sign in may not work at all on many versions
