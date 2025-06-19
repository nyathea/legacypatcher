# TwitterLegacyPatcher
tweak to force older twitter for iOS versions to work again.

this does this by:
- disabling ssl pinning in the app
- spoofing the app version
- fix images by replacing pic.x.com to pic.twitter.com in the 

and it also includes some QoL features like:
- removing useless fleets bar
- no ads

Tested on twitter v7.29.1, v8.58, v8.71

## Known issues
- currently on 8.58 (and presumably other 8.x versions) trying to log in will result in an crash. the current workaround seems to be downgrading to 7.29.1, login normally, and then upgrade back to your specified version. 8.71 requires an valid att token to login
- on 8.58/8.71 everything works except for video playback (hit or miss), viewing quote tweets on tweets, banner images, explore/search, and translating tweets. on some versions you cant like tweets either because its trying to use an dead endpoint.
