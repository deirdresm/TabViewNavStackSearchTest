# TabViewNavStackSearchTest

Was trying to sort out how exactly to make `.searchable` work in the context of NavigationStack inside TabView. Note that all tabs share the same search text, they just interpret it differently because of differing data models.

* SwiftUI
* SwiftData
* TabGroup
* NavigationStack
* Searchable
* Sorting
* …and Toolbar to work together.

This is a little example, hope it helps you.

## To Start

Launch, click lightning bolt to import defaults (only enabled on macOS).

## Tested on macOS, not iOS

Should add, I wrote and tested this on macOS (as this is an exercise for a macOS app I'm working on for myself). Not tested on iOS etc., but theoretically should work, just missing a lot of creature comforts as this is a study piece.
