# fit-checker
 Fit-checker 2.0 for CTU FIT

## What is FIT-Checker for iOS
_**FIT-Checker** for iOS is a simple app which helps you to stay up to date
with your latest classification._

## tl; dr Quick setup
* Clone the repo `git clone https://github.com/jakub-tucek/fit-checker`
* .. take a coffee :coffee:
* Install [Carthage](https://github.com/Carthage/Carthage) dependency manager
* Install [SwiftGen](https://github.com/AliSoftware/SwiftGen) for automated code generation
* Download and build dependencies: `carthage bootstrap --platform iOS --no-use-binaries`
* Build the project with XCode: <kbd>cmd ⌘</kbd> + <kbd>r</kbd>
* :tada: Have fun! :tada:

## Content
* [What is FIT-Checker](#what-is-fit-checker-for-ios)
* [Quick setup](#tl-dr-quick-setup)
* [Setup](#setup)
* Features
  * [Supported](#supported-features)
  * [Upcoming](#roadmap--upcoming-features)
* [How it works](#how-it-works)
* [Dependencies](#project-dependencies)
* [Contribution](#help-needed)
* [License](#license)

## Setup
Ok, quick setup is not that descriptive, lets make a tear down.

First things first,
clone the repo from Github:

```bash
$ git clone https://github.com/jakub-tucek/fit-checker
```

Once the repository is cloned, you have to install dependencies. We use [Carthage](https://github.com/Carthage/Carthage) instead of CocoaPods
as dependency manager. Follow [this guide](https://github.com/Carthage/Carthage#installing-carthage)
and install latest stable version of Carthage.

Because we believe that Swift and its ecosystem should be strongly typed and
code validity should be checked at build time, we use [SwiftGen](https://github.com/AliSoftware/SwiftGen) to generate boilerplate code.
For now, SwiftGen automatically generates Enums with text translations. Check
[this guide](https://github.com/AliSoftware/SwiftGen#installation) for SwiftGen
installation walkthrough.

Now the dependencies itself. Nothing fancy, run:

```bash
$ carthage bootstrap --platform iOS
```

**If you see any build errors after installation** caused by incompatible Swift version,
run `update` command on corrupted library with `--no-use-binaries` option. We are now
experiencing some issues with KeychainAccess binary, so after the `bootstrap` finishes,
we use:

```bash
$ carthage update KeychainAccess --no-use-binaries --platform iOS
```

Now you should be ready to run the app without any problem. If the app cannot be build,
please create a new issue if it's not already created.

## Supported features
* Download list of your courses for current semester
* Preview detail of course classification
* Background refresh (download data while the app is in background, **but not killed!**)
* Pull to refresh on course list
* Offline first - see last downloaded classification while you are not online
* Czech and English interface

## Roadmap / Upcoming features
* Local notifications - get notified when your classification is changed while the app is killed
* Lunch Guy - see current menu for restaurants near campus
* ISIC account balance
* KOS integration
* Deeper Edux integration

## How it works
How the app works under the hood? For classification and courses informations we use Edux as main (eh, the only one) source. Since Edux does not have any APIs, FIT-Checker browse the web in background and parse HTML into model objects.

Login credentials **stays** on your device, FIT-Checker only uses it to obtain access tokens (usually once per session) to sign network requests.

Because iOS does not allow app to run itself periodically, local notifications are not supported yet but will be added in one of the future releases.

## Project dependencies
We use external libraries to for a faster development, here is the list:

* [Kanna](https://github.com/tid-kijyun/Kanna) - XML and HTML parser, [MIT](https://github.com/tid-kijyun/Kanna/blob/master/LICENSE)
* [Realm](https://github.com/realm/realm-cocoa) - Mobile database, [Apache 2.0](https://github.com/realm/realm-core/blob/master/LICENSE)
* [Alamofire](https://github.com/Alamofire/Alamofire) - Networking library, [MIT](https://github.com/Alamofire/Alamofire/blob/master/LICENSE)
* [KeychainAccess](https://github.com/kishikawakatsumi/KeychainAccess) - Keychain wrapper, [MIT](https://github.com/kishikawakatsumi/KeychainAccess/blob/master/LICENSE)
* [SwiftyBeaver](https://github.com/SwiftyBeaver/SwiftyBeaver) - Advanced logging platform, [MIT](https://github.com/SwiftyBeaver/SwiftyBeaver/blob/master/LICENSE)

We would like to thank the community for such a great work. Big thanks goes to all
the contributors of mentioned libraries.

## Help needed!
While we are busy maintaining current features and adding new, the UI and UX
are kinda neglected. We are looking for someone who can help us with some
design improvements. Feel free to contact us or create an issue!

## License
This repository is licensed under [MIT](LICENSE).

