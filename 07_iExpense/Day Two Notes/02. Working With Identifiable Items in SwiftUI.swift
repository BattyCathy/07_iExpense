//
//  02. Working With Identifiable Items in SwiftUI.swift
//  07_iExpense
//
//  Created by Austin Roach on 2/9/21.
//

import Foundation

//When we create static views in SwiftUI - when we hard-code a VStack, then a TextField, then a Button, and so on - SwiftUI can see exactly which views we have and is able to control them, animate them, and more. But when we use List or ForEach to make dynamic views, SwiftUI needs to know how it can identify each item uniquely otherwise it's not able to compare view hierarchies to figure out what has changed.

//In our current code, we have this:

/*
 ForEach(expenses.items, id: \.name) { item in
    Text(item.name)
 }
 .onDelete(perform: removeItems)
 */

//In English, that means, "create a new row for every item in expense items, identified uniquely by its name, shwoing that name in the row, and calling the removeItems() method to delete it."

//Then, later, we have this code:

/*
 Button(ation: {
    let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
    self.expenses.items.append(expense)
 }) {
    Image(systemName: "plus")
 }
 */

//Every time that button is pressed, it adds a test expense to our list, so we can make sure adding and deleting works.

//Can you see the problem?

//Every time we create an example, we're using the name "Test", but we've also told SwiftUI that it can use the expense name as a unique identifier. So, when our code runs and we delete an item, SwiftUI looks at the array beforehand - "Test", "Test", "Test, "Test" - then looks at the array afterwards - "Test", "Test", "Test" - and can't actually tell what changed. Something has changed, because one item has disappeared, but SwiftUI can't be sure which. As a result, it takes the simplest option and just removes the last one from the table.

//This is a logic error on our behlaf: our code is fine, and it doesn't crash at runtime, but we've applied the wrong logic to get to that end result - we've told SwiftUI something will be a unique identifier when it isn't unique at all.

//To fix this we need to think more about our ExpenseItem struct. Right now it has three properties: name, type, and amount. The name by itself might be unique in practice, but it's als likely not to be -as soon as the user enters "Lunch" twice we'll start hitting problems. We could perhaps try to combine the name, type and amount into a new computed property, but even then we're just delaying the inevitable; it's still not really unique.

//The smart solution here is to add something to ExpenseItem that is unique, such as an ID number that we assign by hand. That would work, but it does mean tracking the last number we assigned so we don't use duplicates there either.

//There is in fact an easier solution, and it's called UUID - short for "universally unique identifier", and if that doesn't sound unique I'm not sure what does.

//UUIDs are long hexadecimal strings such as this one: 08B15DB4-2F02-4AB8-A965-67A9C90D8A44. So, that's eight digits, four digits, gour digits, four digits, then twelve digits, of which the only requirement is that there's a 4 in the first number of the third block. If we subtract the fixed 4, we end up with 31 digits, each of which can be one of 16 values - if we generated 1 UUID every second for a billlion years, we might being to have the slightest chance of generating a duplicate.

//Now, we could update ExpenseItem to have a UUID property like this:

/*
 struct ExpenseItem {
    let id: UUID
    let name: String
    let amount: Int
 }
 */

//And that would work. However, it would also mean we need to genrate a UUID by hand, then load nd save the UUID along with our other data. So, in this instance we're going to ask Swift to generate a UUID automatically for us like this:

/*
 struct ExpenseItem {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
 }
 */

//Now we don't need to worry about the id value of our expense items - Swift will make sure they are always unique.

//With that in place we can now fix our ForEach, like this:

/*
 ForEach(expenses.items, id: \.id) { item in
    Text(item.name)
 }
 
 */


//If you run the app now you'll see our problem is fixed: SwiftUI can now see exactly which expense item got deleted, and will animate everything correctly.

//We're not done with this step quite yet,though. Instead, I'd like you to modify the ExpenseItem to make it conform to a new protocol called Identifiable, like this:

/*
 struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let ype: String
    let amount: Int
 }
 */


//All we've done is add Identifiable to the list of protocol conformances, nothing more. This is one of the protocols built into SWift, and means "this type can be identified uniquely." It has only one requirement, which is that there must be a property called id that contains a unique identifier. We just added that, so we don't need to do any extra work - our type conforms to Identifiable just fine.

//Now, you might wonder why we added that, because our code was working fine before. Well, because our expense items are now guaranteed to be identifiable uniquely, we no longer need to tell ForEach because that's the point of the Identifiable protocol.

//So, as a result of this change we can modify teh ForEach again, to this:

/*
 ForEach(expenses.items) { item in
    Text(item.name)
 */

//Much better!!
