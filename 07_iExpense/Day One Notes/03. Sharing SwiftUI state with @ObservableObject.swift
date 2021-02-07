//
//  Sharing SwiftUI state with @ObservableObject.swift
//  07_iExpense
//
//  Created by Austin Roach on 2/6/21.
//

import Foundation


//If you want to use a class with your SwiftUI data - which you will want to do if that data should be shared across more than one view - then SwiftUI gives us two property wrappers that are useful: @ObservedObeject and @EnvironmentObject. We'll be looking at environment object later on, but for now, let's focus on observed objects.

//Here's some code that creates a User class, and shows that user data in a view:

/*
 class User {
    var firstName = "Bilbo"
    var lastName = "Baggins"
 }
 
 struct ContentView: some View {
    @State private var user = User()
 
    var body: some View {
        VStack {
            Text("Your name is \(user.firstName) \(user.lastName)
        }
    }
 }
 */

//However, the code won't work as inteded: we've marked the user property with @State, which is designed to track local structs rather than external classes. As a result, we can type into the text fields, but the text view above won't be updated.

//To fix this, we need to tell SwiftUI whe interesting parts of our class have changed. By "interesting" chanes, we want to notify any views that are watching our class that a change has happened so they can be reloaded. We can do this using the @Published property observer, like this:

/*
 class User {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
 }
 */

//@Published is more or less half of @State: it tells Swift that whenever either of those two properties changes, it should send an announcement out to any SwiftUI views that are watching that they should reload.

//How do those views know which classes might send out these notifications? hat's another property wrapper, @ObservedObject, which is the other half of @State - it tells SwiftUI to watch a class for any change anouncements.

//So, change the user property to this:

//@ObservedObject var user = User()

//I removed the private access control there, but whether or not you use it depends on you usage - if you're intending to share that object with other views then marking it as private will just cause confusion.

//Now that we're using @ObservedObject, our code will no longer compile. It's not a problem, and in fact its expected and easy to fix: the @ObservedObject property wrapper can only be used on types that conform to the ObservableObject protocol. This protocol has no requirements, and really all it means is "we want the other things to be able to monitor this for changes."

//So, modify the User class to this:

/*
 class User: ObservableObject {
    @Published var firstName = "Bilbo"
    @Published var lastName = "Baggins"
 */


//Our code will now compile again, and even better, it will now actually work again - you can run the app and see the text view update when either the text view update when either text field is changed.

//As you've seen, rather than just using @State to declare a local state, we now take three steps:

//--Make a class that conforms to the @ObservableObject protocol

//--Mark some properties with @Published so that any views using the class get update when they change.

//--Create an instance of our class using the @ObservedObject property wrapper

//The end result is that we can have our state stored in an external object, and, even better, we can now use that object in multiple views and have them all point to the same values.


