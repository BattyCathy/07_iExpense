//
//  Why @State only works with Structs.swift
//  07_iExpense
//
//  Created by Austin Roach on 2/6/21.
//

import Foundation


//MARK: Why @State only works with structs

//SwiftUI's State property wrapper is designed for simple data that is local to the current view, but as soon as you want to share data between views it stops being useful.

//Let's break this down with some code - here's a struct to stoe a user's first and last name:

/*
 struct User {
    var firstname = "Bilbo"
    var lastName = "Baggins"
 }
 */

//We can now use that in a SwiftUI view by creating an @State property and attaching things to $user.firstName and $user.lastName, like this:

/*
 struct ContentView: View {
    @State private var user = User()
 
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName).")
 
            TextField("First Name", text: $user.firstName)
            TextField("Last Name", text: $user.lastName)
        }
    }
 }
 */


//That all works: SwiftUI is smart enough to understand that one object contains all our data, and will update the UI when either value changes. Behind the scenes, what's actually happening is that each time a value inside our struct changes the whole struct changes - it's like a new user every time we type a key for the first or last name. That might sound wasteful, but it's actually extremely fast.

//Previously we looked at the difference between classes and structs, and there are two important differences I mentioned. First, that structs have unique owners, whereas with classes multiple things can point to the same value. And second, that classes don't need the mutating keyword before methods that change their properties, because you can change properties of constant classes.

//In practice, what this actually means is that if we want to share data between multiple views - if we want two or more views to point to the same data so that when once changes they all get those changes - we need to use classes rather than structs.

//So, please change the User struct to tho be a class. From this:

//struct User {

//To this:

//class User {

//Now run the progrma again and see what you think.

//Spoiler: it doesn't work any more. Sure, we can type into the text fields just like before, but the text view above it doesn't change.

//When we us @State, we're asking SwiftUI to wastch a property for changes. So, if we change a string, flip a Boolean, add to an array, and so one, the property has changed and SwiftUI will re-invoke the body property of the view.

//When User was a struct, every time we modified the a property of that sruct Swift was actually creating a new instance of the struct. @State was able to spot that change, and automatically reloaded our view. Now that we have a class, that behavior no longer happens: Siwft can just modify the value directly.

//Remember how we had to use the mutating keyword for struct methods that modify properties? This is because if we create the structs properties as variable but the struct itself is constant, we can't change the properties - Swift needs to be able to destroy and recreate the whole struct when a property changes, and that isn't possible for constant structs. Classes don't need the mutating keyword, because even if the class instance is marked as constant Swift can still modify variable properties.

//I know that all sounds terribly theoretical, but here's the twist: now that SUer is a class the property itself isn't changing, so @State doesn't notice anything and can't reload the view. Yes, the values inside the class are cahnging, but @State doesn't monitor those, so effectively what's happening is that the values inside our class are bering changed but the view isn't being reloaded to reflect that change.

//To fix this, it's time to leave @State behind. Instead we need a more powerful property wrapper called @ObservedObject - let's look at that now...
