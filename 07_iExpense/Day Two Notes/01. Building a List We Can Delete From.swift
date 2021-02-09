//
//  01. Building a List We Can Delete From.swift
//  07_iExpense
//
//  Created by Austin Roach on 2/9/21.
//

import Foundation


//In this project we want a list that can show some expenses, and previously we would have done this using an @State array of objects. Here, though, we're going to tak a different approach: we're going to create an Expense class that will be attached to our list using @ObservedObject.

//This might sound like we're over complicating things a little, but it actually makes things much easier because we can make the Expenses class load and saave itself seamlessly - it will be almost invisible, as you'll see.

//First, we need to decide what an expense it - what do we want it to store? In this instance it will be three things: the name of the item, whether it's businees or personal, and its cost as an integer.

//We'll add more to this later, but for now we can represent ll that using a single ExpenseItem struct. You can put this inot a new Swift fiile called EpenseItem.swift, but you don't need to - you can just put this into ContentView if you like, as longs as you don't put it inside the ContentView struct itself.

//Regardless of where you put it, this is the code to use.

/*
 struct ExpenseItem {
    let name: String
    let type: String
    let amount: Int
 }
 */

//Now that we have something that represents a single expense, the next step is to create something to store an array of those expense items inside a single object. This needs to conform to the ObservableObject protocol, and we're also going to use @Published to make sure change announcements get snet whenever the items array gets modifier.

//As with the ExpenseItem struct, this will start off simple and we'll add to it later, so add this new class now:

/*
 class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
 }
 */

//That finishes all the data required for our main view: we have a struct to represent a single item of expense, and a class to store an array of all of those items.

//Let's now put that into action with our SwiftUI view, so we can actually see our data on the screen. Most of our view will just be a list showing the items in our expenses, but because we want users to delete items they no longer want we can't just use a simple List - we need to use a ForEach inside the list, so we get access to the onDelete() modifier.

//First, we need to add an @ObservedObject property in our view that will create an instance of our Expenses class:

//@ObservedObject var expenses = Expenses()

//Remember, using @ObservedObject here asks SwiftUI to watch the object for any change announcements, so any time one of our @Published properties changes the view will refresh its body.

//Second, we can use that Expenses object with a NavigationView, a List, and a ForEach, to create our basic layout:

/*
 NavigationView {
    List {
        ForEach(expenses.items, id: \.name) { item in
            Text(item.nameP
        }
    }
    .navigationBarTitle("iExpense")
 }
 */

//That tells the ForEach to identify each expense item uniquely by its name, then prints our the name as the list row.

//We're going to add two more things to our simple layout before we're done: the ability to add new items for testing purposes, and the ability to delete items with a swipe.

//We're going to let users add their own items soon, but it's important to check that our list actually works well before we continue. So, we're going to add a trailing bar button item that adds example ExpenseItem instance  for us to work with. Add this modifier to the list now:

/*
 .navigationBarItems(trailing:
    Button(action: {
        let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
        self.expenses.items.append(expense)
    }) {
        Image(systemName: "plus")
    }
 */

//That brings our app to life: you can launch it now, then press the + button repeatedly to add lots of testting expenses.

//Now that we can add expenses, we can also add code to remove them. This means adding a method capable of deleting and IndexSet of list items, then passing that directly to our expenses array:

/*
 func removeItems(at offsets: IndexSet) {
    expenses.items.remove(atOffsets: offsets)
 }
 */

//And to attach that to SwiftUI, we add an onDelete() modifier to our ForEach, like this:

/*
 ForEach(expenses.items, id: \.name) { item in
        Text(item.name)
 }
 .onDelete(perform: removeItems)
 */

//Go ahead and run the app now, press + a few times, then swipe to delte the rows.

//Now try doing it while looking carefully. What do you notice? You should see adding items worksfine, but deleting behaves just a little oddly: swipe in a little on your first row then tap its Deete button; you should see that the row slides back into place as normal, then the item at the end gets removed.

//What's going on? Well, it turns out we lied to SwiftUI, and that lie is coming back to caus problems...
