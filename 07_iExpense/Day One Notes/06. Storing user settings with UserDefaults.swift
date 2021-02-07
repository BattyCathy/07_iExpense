//
//  06. Storing user settings with UserDefaults.swift
//  07_iExpense
//
//  Created by Austin Roach on 2/7/21.
//

import Foundation

//MARK: Storing User Settings with UserDefaults

//Arguably the biggest difference between a website and an app is their approach to user data. On one hand, websites do their best to invade privacy by tracking cookies, serving up remarketing adverts, and watching every move we make, so vey few users want to trust them with more data. On the onther hand, we pretty much expect apps to store our data - we want them to, and it woud be odd id every app launched with a GDPR "can we serve you cookies?" notice.

//So, it's no surprise that iOS gives us several ways to read and write user data, and I want to look at two of them here.

//The first is called UserDefaults, and it allows us to store small amount of user data directly attached to our app. There is no specific number attached to "small", but you should keep in mind that everything yout store in UserDefaults will automatically be loaded when your app launches - if you store a lot in there you app launch will slow down. To give you at least an idea, you should aim to store no more than 512kb in there.

//Tip: If you're thinking "512KB? How much is that? then let me give you a rouch estimate: it's about as much text as all the chapters that you've read in this book so far.

//UserDefaults is perfect for storing user settings and other important data - you might track when the user last launched the app, which news story they last read, or other passively collected information.

//However, there is a catch: it is stringly typed. This is a bit of a joe name, because "strongly typed" means a type-safe language like Swift where each constant and variable has a specific type such as Int or String, but "stringly typed" means some code that uses strings in places where they might cause problems.

//Enough chat - let's look at some code. Here's a view with a button that shows a tap counts, and incrmemtns that count every time the button is tapped.

/*
 struct ContentView: View {
    @State private var tapCount = 0
 
    var body: some View {
        Button("Tap Count: \(tapCount)") {
            self.tapCount += 1
        }
    }
 }
 */

//As this is clearly A Very Important App, we want to save the number of taps that the user made, so when they come back to the app in the future they can pick up where they left off.

//Well, making that happen only takes two changes. First, we need to write the tap count to UserDefaults whenever it changes, so add this after the line self.tapCount += 1:

//UserDefaults.standard.set(self.tapCount, forKey: "Tap")

//In just that single line of code you can see three things in action:

// 1. We need to use UserDefaults.standard. This is built-in instance of UserDefaults that is attached to our app, but in more advanced app you can crreate your own instances. For example, if you want to share defaults across several app extensions you might create your own UserDefaults instnace.

// 2. There is a single set() method that accepts any kind of data - integers, Booleans, strings, and more.

// 3. We attach a string name to this data, in our case it's the key "Tap". This key is case sensitive just like regular Swift strings, and it's important - we need to use the same key to read the data back out of UserDefaults.

//Speaking of reading data back, rather than start with tapCount set to 0 we should instead make it read the value back from UserDefaults like this:

//@State private var tapCount = UserDefaults.standard.integer(forKey: "Tap")

//Notice how that uses exatly the same key name, which ensures it read the same integer value.

//Go ahead and give the app a try and see what you think - you ought to be able to tap the button a few times, go back to Xcode, run the app again, and see the number exactly where you left it.

//There are two things you can't see in that code, but both matter. First, what happens if we don't have the "Tap" key set? This will be the case the very first time the app is run, but as you just saw it works fine - if the key can't be found it just sends back 0.

//Sometimes having a default value llike 0 is helpful, but other times it can be confusing. With Booleans, for example, you get back false if boolean(forKey:) can't find the key you asked for, but is that false a value you set yourself, or does it menad there was no value at all?

//Second, it take iOS a little time to write you data to permanent storage - to actually save that change to the device. They don't write updates immediately because you might make several back to back, so instead they wait some time then write out all the changes at once. How much time is another number we don't know, but a couple of seconds ought to do it.

//As a result of this, if you tap the button then quickly relaunch the app from Xcode, you'll find your most recent tap count wan't saved. There used to be a way of forcing updates to be written immediately, but at this point it's worthless - even if the user immediately started the process of terminating you app after making a choice, your defaults data would be written immediately for nothing will be lost.

