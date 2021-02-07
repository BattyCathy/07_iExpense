//
//  04 Showing and Hiding Views.swift
//  07_iExpense
//
//  Created by Austin Roach on 2/6/21.
//

import Foundation

//There are several ways of showing views in SwiftUI, and one of the most basic is a sheet: a new view presented on top of our existing one. On iOS this automatically gives us a card-like presentation where the current view slides away into the distance a little and the new view animated in on top.

//Sheets work much like alerts, in that we don't present them directly with code such as mySheet.present() or similar. Instead, we define the conditions under which a sheet should be shown, and when those conditions become true or false the sheet will either be presented or dismissed respectively.

//Let's start with a simple example, which will be showing oneview from another using a sheet. First, we create the view we want to show inside a sheet, like this:

/*
 struct SecondView: View {
    var body: some View {
        Text("Second View")
    }
 }
 */

//There's nothing special about that view at all - it doesn't know it's going to be shown in a sheet, and doesn't need to know it's going to be shown in a sheet.

//Next, we create our initial view, which will show the second view. We'll make it simple, then add to it:

/*
 struct ContentView: View {
    var body: some View {
        Button("Show Sheet") {
            // show the sheet
        }
    }
 }
 */

//Filling that in requires four steps, and we'll tackle them individually.

//First, we need some state to track whether the sheet is showing. Just as with alerts, this can be a simple Boolean, so add this property to ContentView now:

//@State private var showingSheet = false

//Second, we need to toggle that when the button is tapped, so replace the // show the sheet comment with this:

//self.showingSheet.toggle()

//Third, we need to attach our sheet somewhere to our view hierarchy. If you remember, we show alerts using alert(isPresented:) with a two-way binding to our state property, and we use something almost identical here: sheet(isPesented:)

//sheet() is a modifer just like alert(), so please add this modifier to our button now:

/*
 .sheet(isPresented: $showingSheet) {
    // contents of the sheet
 }
 */

//Fourth, we need to decide what should actually be in the sheet. In our case, we already know exactly what we want: we want to create and show an instance of SecondView. In code that mean writing SecondView(), then... er.. well, that's it.

//So, the finished ContentView struct should look like this:

/*
 struct ContentView: View {
    @State private var showingSheet = false
 
    var body: some View {
        Button("Show Sheet") {
            self.showingSheet.toggle()
        }
        .sheet(isPresented: $showingSheet) {
            SecondView()
        }
    }
 }
 */

//If you run the program now you'll see you can tap the button to have our second view slide upwards from the bottom, and you can then drag that down to dismiss it.

//When you create a view like this, you can pass in any parameters it needs to work. For example, we could require that SecondView be sent a name it can display, like thisL

/*
 struct SecondViw: View {
    var name: String
 
    var body: some View {
        Text("Hello, \(name)
    }
 }
        
 */

//And now just using SecondView() in our sheet isn't good enough - we need to pass in a name string to be shown. For example, we could pass in my Twitter username like this:

/*
 .sheet(isPresented: $showingSheet) {
        SecondView(name: "@twostraws")
 }
 */

//Now the sheet will show "Hello, @twostraws".

//Swift is doing a ton of work on our behalf here: as soon as we said that SecondView has a name property, Swift ensured that our code wouldn't even build until all instance of SecondView() became SecondView(name: "some name"), which eliminates a whole hange of possible errors.

//Before we move on, there's one more thing I want to demonstrate, which is how to make a view dismiss itself. Yes, you've ssen that the user can just swipe downwards, but sometimes you will want to dismiss views programatically - to make the view go away because a button was pressed, for example.

//SwiftUI gives us two ways of doing this, but the easiest one is using another property wraper, and yes, I realize that so often the solution to a problem in SwiftUI is to use another property wrapper.

//Anyway, this one is called @Environment, and it allows us to create properties that store values provided to us externally. Is the user in light mode or dark mode? Have they asked for smaller or larger fonts? What timezone are they on? All these and more are values that some from the environment, and in this instance we're going to read our view's presentation mode from the environment.

//The presentation mode of a view contains only two pieces of data, but both are useful: a property storing whether the view is currently presented on screen, and a method to lets us dismiss the viewimmediately.

//To try it our, add this property to SecondView, which create a property called presentationMode attached to the presentation mode variable stored in the apps environment.

//@Environment(\.presentationMode) var presentationMode

//Now replace the text view in SecondView with this button:

/*
 Button("Dismiss") {
    self.presentationMode.wrappedValue.dismiss()
 }
 */

//The addition of wrappedValue in there is required, because presentationMode is actually a binding so it can be updated automatically by the system - we need to dig inside it to retrieve the actual presentaion mode for us to dismiss the view.

//Anyway, with that button in place, you should now find you can show and hide the sheet using button presses.
