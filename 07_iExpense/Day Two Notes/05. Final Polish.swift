//
//  05. Final Polish.swift
//  07_iExpense
//
//  Created by Austin Roach on 2/10/21.
//

import Foundation

//If you try using the app you'll soon see it has two problems:

//1. Adding an expense doesn't dismiss AddView; it just stays there.

//2. When you add an expense, you can't actually see any details about it.

//Before we wrap up this project, let's fix those to make the whole thing feel a little more polished.

//First, dismissing AddView is done by storing a referrence to the view's presentationn mode, then calling dismiss() on it when the time is right. The presentation mode is controlled by the view's environment, and links to the isPresented parameter for our sheet - that Boolean gets set to true by us to show AddView, but will be flipped back to false by the enivronment when we call dismiss() on the presentation mode.

//Start by adding this property to AddView:

//@Environment(\.presentationMode) var presentationMode

//You'll notice we don't specify a type for that - Swift can figure it out thanks to the @Environment property wrapper.

//Next, we need to call presentationMode.wrappedValue.dismiss() when we want the view to dismiss itself. This causes the showingAddExpense Boolean in ContentView to go back to false, and hides the AddView. We aready have a Save button in AddView that creates a new expense item and appends to our existing expenses, so add this one on the line directly after:

//self.presentationMode.wrappedValue.dismiss()

//That solves the first problem, which just leaves the second: we should show the name of each expense item but nothing more. This is because the ForEach in our list is trivial:

/*
 ForEach(expenses.items) { item in
    HStack {
        VStack(alignment: .leading) {
            Text(item.name)
                .fornt(.headline)
            Text(item.type)
        }
 
        Spacer()
        Text("$\(item.amount)")
    }
 }
 */

//Now run the program one last time and try it our - we're done!
