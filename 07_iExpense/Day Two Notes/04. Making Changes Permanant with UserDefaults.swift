//
//  04. Making Changes Permanant with UserDefaults.swift
//  07_iExpense
//
//  Created by Austin Roach on 2/9/21.
//

import Foundation


//At this point, our app's user interface is functional: you've seen we can add and delte items, and now we have a sheet showing a user interface to create new expenses. However, the app is far from working: any data placed into AddView is completely ignored, and  even if it weren't ignored then it still wouldn't be saved for future times the app is run.

//We'll tackle those problems in order, starting with actually doing something with the data from AddView. We already have properties that store the values from our form, and previously we added a property to store an Expenses object passes in from the ContentView.

//We need to put those two things together: we need a button that, when tapped, creates an ExpenseItem out of our properties and adds it to the expenses items. Our ExpenseItem struct has an integer for its amount, which means we need to do a little typecasting from the string value of amount.

//Add this modifier below navigationBarTitle() in AddView:

/*
 .navigationBarItems(trailing: Button("Save") {
    if let actualAmount = Int(self.amount) {
        let item = ExpenseItem(name: self.name, type: slef.type, amount: actualAmount)
        self.expenses.items.append(item)
    }
 })
 */

//Although we have more work to do, I encourage you to run the app now because it's actually coming together - you can now show the add view, enter some dtails, press "Save", the swipe to dismiss, and you'll see your new item in the list. That means our data synchronization is working perfectly: both the SwiftUI views are reading from the same list of expense items.

//Now try launching the app again, and you'll immediately hit our second problem: any data you add isn't stored, meaning that everything starts blank every time you relaunch the app.

//This is obviously a pretty terrible user experience, but thanks to the way we have Expense as a separate class it's actually not that hard to fix.

//We're going to leverage four important technologies to help us save and load data in a clean way:

//--The Codable protocol, which will allow us to archive all the existing expense items ready to be stored.

//--UserDefaults, which will let us save and load that archived data.

//--A custom initializer for the Expenses class, so that when we make an instance of it we load any saved data from UserDefaults

//--A didSet property observer on the items property of Expenses, so that whenever an item gets added or removed we'll write out changes.

//Let's tackle writing the data first. We already have this property in the Expenses class:

//@Published var items: [ExpenseItem]

//That's where we store all the expense item structs that have been created, and that's also where we're going to attach our property observer to write out changes as they happen.

//This takes four steps in total: we need to create an instance on JSONEnconder that will do the work of converting our data to JSON, we ask that to try encoding our items array, and the we can write that to UserDefaults using the key "Items".

//Modify the items property to this:

/*
 @Published var items: [ExpenseItem] {
    didSet {
        let encoder = JSONEncoder()
        if let encoded = try? encoder.encode(items) {
            UserDefaults.standard.set(encoded, forKey: "Items")
        }
    }
 }
 */

//Now, if you're following along you'll notice that code doesn't actually compile. And if you're following along closely, you'll have notive that I said this process takes four steps, while only listing three.

//The problem is that the encoder.encode() method can only archive objests that conform to the Codable protocol. Remember, conforming to Codable is what asks the compiler to generate code for us to handle archving and unarchiving objects, and if we don't add a conformance for that then our code won't build.

//Helpfully, we don't need to do any work other than add Codable to ExpenseItem, like this:

/*
 struct ExpenseItem: Identifiable, Codable {
    let  id = UUID()
    let name: String
    let type: String
    let amount: Int
 }
 */

//Swift already includes Codable conformances for the UUID, String, and Int properties of ExpenseItem, and so it's able to make ExpenseItem conform automatically as soon as we ask for it.

//With that change, we've written all the code needed to make sure our items are saved when the user adds them. However, it's not effective by itself: the data might be saved, but it isn't loaded again when the app relaunches.

//To solve that - and also make our code compile again - we need to implement a custom initializer. That will:

// 1. Attempt to read the "items" key from UserDefaults.

// 2. Create an instance of JSONDecoder, which is the counterpart of JSONEncoder that lets us go from JSON data to Swift objects.

// 3. Ask the decoder to convert the data we recieved from UserDefaults into an array of ExpenseItem objects.

// 4. If that worked, assign the resulting array into items and exit.

// 5. Otherwise, set items to be an empty array.

//Add this initializer to the Expenses class now:

/*
 init() {
    if let items = UserDefaults.standard.data(forKey: "Items") {
        let decoder = JSONDecoder()
        if let decoded = try? decoder.decode([ExpenseItem].self, from: items) {
            self.items = decoded
            return
        }
    }
 
    self.items= []
 }
 */

//The two key parts of that code are the data(forKey: "Items") line, which attempts to read whatever is in "Items" as a Data object, and try? decoder.decode([ExpenseItem].self, from: items), which does the actual job of unarchiving the Data object into an array of ExpenseItem objects.

//It's common to do a bit of a double take when you first see [ExpenseItem].self - what does the .self mean? Well, if we had just used [ExpenseItem], Swift would want to know what we meant - are we trying to make a copy of the class? Were we planning to reference a static property or method? Did we perhaps mean to create an instance of the class? To avoid confusion - to say that we mean we're referring to the type itself, known as the type object - we write .self after it.

//Now that we have both loading and saving in place, you should be able to use th app. It's not finished quite yet though - let's add some final polish!
