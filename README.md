# Marvel for Keynote

<img src="/docs/images/github-header.png?raw=true" width="888">

Marvel for Keynote is an open-source Mac app to send your Keynote files to [Marvel](https://marvelapp.com) - a design collaboration platform that brings ideas to life.

[Download it here](https://marvelapp.com)

**Why it's so amazing**

* Send your Keynote files to Marvel so people without Keynote can view your presentation.
* Create quick wireframes in Keynote and finish them off as a prototype in Marvel

Built using the Marvel GraphQL API - [get started here](https://marvelapp.com/developers/).

Questions? Hit us up on [Twitter](http://twitter.com/marvelapp)

## 🎒 Before building (dependencies)

* Install [Xcode](https://developer.apple.com/xcode/)
* Install [CocoaPods](https://cocoapods.org)
* Run `pod install`
* Add a `Secrets.swift` file inside the `Config` folder and change the details

Example:

```
class Secrets {

    class Marvel {

        static let baseURL = "https://marvelapp.com"
        static let clientId = ""
        static let clientSecret = ""
        static let scopes = "user:read projects:read projects:write company:read company.projects:read"
        static let redirectURI = "m4k://redirect"

    }

}
```

## 🚧 Building

* Run the `MarvelForKeynote` target in Xcode from the .workspace file.
