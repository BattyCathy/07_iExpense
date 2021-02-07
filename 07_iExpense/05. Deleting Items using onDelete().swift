//
//  05. Deleting Items using onDelete().swift
//  07_iExpense
//
//  Created by Austin Roach on 2/7/21.
//

import Foundation

//MARK: Deleting Items Using onDelete()

//SwiftUI gives us the onDelete() modifier for us to use to control how objects should be deleted from a colllection. In practice, this is almost exclusively used with List and ForEach: we create a list of rows that are shown using ForEach, then attach onDelete() to that forEah so the user can remove rows they don't want.

//This is another place where SwiftUI does a heck of a lot of work on our behalf, but it doeshave a few interesting quirks as you'll see.

//Firstt lets construct an example we can work with: a list that shows numbers, and every time we tap the button a new number appears. Here's the code for that:

/*
 struct ContentView: View {
    @State private var numbers = [Int]()
    @State private var currentNumber = 1
 
    var body: some View {
        VStack {
            List {
                ForEach(numbers, id: \.self) {
                    Text("\($0)")
                }
            }
        }
    }
 }
 */

//Now you might think that the ForEach isn't needed - the list is made up of entirely dynamic rows, so we could write instead:

/*
 List(numbers, id: \.self) {
    Text("\($0)")
 }
 */

//That would also work, but here's our first quirk: the onDelete modifier only exists on ForEach, so if we want users to delete items from a list we must put the items inside a ForEach. This does mean a small amount of extra code for the times when we only have dynamic rows, but on the flip side it means it's easier to create lists where only some rows can be delted.

//In order to make onDelete() work, we need to implement a method that will recieve a single parameter of type IndexSet. This is a bit like a set of integers, except it's sorted, and it's just telling us the positions of all the items in the ForEach that should be removed.

//Because our ForEach was created enntirely from a single array, we can actually just pass that indec set straight to our numbers array - it has a special remove(atOffsets:) method that accepts an index set.

///So, add this method to ContentView now:

/*
 func removeRows(at offsets: IndexSet) {
    numbers.remove(atOffsets: offsets)
 }
 */


//Finally we can tell SiwftUI to call that method when it wants to delete data from the ForEach, by modifying it to this:

/*
 ForEach(numbers, is: \.self) {
    Text("\($0)")
 }
 onDelete(perform: removeRows)
 */

//Now go ahead and run your app, then add, then add afew numbers, When you're ready, swipe from right to left across nay of the rows in your list, and you should find a delete button appears. You can tap that, or you can also use iOS's swipe to delete funtionality by swiping further.

//Given how easy that was, I think the result works really well. But SwiftUI has another trick up its sleeve: we can add an Edit/Done button to the navigation bar, that lets users delete sereval rows more easily.

//First, wrap your VStack in a NavigationView, then add this modifier to the VStack:

//.navigationBarItems(leading: EditButton())

//That's literally all it takes - if you run the app you'll see you can add some numbers, then tap Edit to start delting rows. When you're ready, tap DOne to exit editing mode. Not bad, given how little code it took!
