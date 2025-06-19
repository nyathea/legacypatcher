# TwitterLegacyPatcher
tweak to force older twitter for iOS versions to work again.

this works by:
- disabling ssl pinning in the app
- spoofing the app version
- fix images by replacing pic.x.com to pic.twitter.com in the 

and it also includes some QoL features like:
- removing the useless fleets bar
- no ads
- remove "Discover More" under tweets
- enable Birdwatch (a.k.a Community Notes) on versions that support it

soon it will also:
- fix banner images on profiles
- fix quote tweets on tweets
- fix translating tweets

## Tested versions
- v7.29.1
- v8.58
- v8.71

## Known issues
- currently on 8.58 (and presumably other 8.x versions) trying to log in will either result in an crash or login will fail. the current workaround seems to be using 7.29.1 first, login through there, and then upgrade back to your specified version.
- on 8.58/8.71 everything works except for video playback (hit or miss), viewing quote tweets on tweets, banner images, explore/search, and translating tweets. on some versions you cant like tweets either because its trying to use an dead endpoint.
