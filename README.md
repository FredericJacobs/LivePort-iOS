Live Port iPhone App - Change.org Hackathon Project
========

## Goal 

We built a tool able to report text, pictures or a video live-stream directly from your phone. The use cases are endless. Earthquakes, Fires, Vandalism, Shootings … People can report anything, anywhere, anytime. 

The system would be crowdsourced and we rely on the community to confirm or deny certain events. 

We also have a subscription-based model where people could subscribe to events close to their location (on iPhones and fixed zone if you want SMS notifications) and be notified when something happens. 

## The iPhone App

The iPhone app is open-source and even better than that, it's free software. So feel free to play with it and hack your own stuff based on this app. We really on two external Frameworks for dealing with media. LiveStreaming is provided by the awesome [OpenTok](http://www.tokbox.com/opentok/api/documentation) and [FilePicker.io](https://developers.filepicker.io/docs/ios/) handles the picture upload. Let me give you a few guidelines to set up the app correctly.

The app is only certified to work under 5.x iOS SDKs. FilePicker.io is reportedly causing the app to crash on iOS 6 beta with the current release. 

Don't forget to :

- auto create the schemes when opening the project in Xcode.
- Fill the FilePicker API Key in the Info.plist file.
- Test the App on an iPhone because the OpenTok SDK was only built for ARMv6/7 architecture.

## Credits

This app is the accomplishment of a team effort by [Bingxin Nancy Chen](http://twitter.com/binxed), [Frederic Jacobs](http://twitter.com/FredericJacobs), [John Markos O'Neill](http://twitter.com/johnmarkos), [Choi Sung](https://www.facebook.com/choi.sung), [Joaquin Mendoza](https://twitter.com/lightgap), [Lane DeBellis](https://www.facebook.com/lane.debellis), [Nicholas Rebhun](https://www.facebook.com/NRFACTOR) and [Gabby Miseroy](https://www.facebook.com/gabby.miseroy) 