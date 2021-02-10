//
//  03. Sharing an Obsreved Object with a New View.swift
//  07_iExpense
//
//  Created by Austin Roach on 2/9/21.
//

import Foundation

//Classes that conform to ObservableObject can be used in more than one SwiftUI view, and all of those views will be updated when the published properties of the class change.

//In this app, we're going to design a view specially for adding new expense items. When the user is ready, we'll add that to our Expense class, which will automatically cause the original view to refresh its data so the expense item can be shown.

//To make a new SwiftUI view you can either press Cmd+N or go to the File menu and choose New > File. Eitehr way, you should select "SwiftUI View" under the User Interface category, then name the file AddView.swift. If you find that the group doesn't have a yellow folder next to it, please select that then make sure you save the file inside the "iExpense" directory alongside your other code. All being well, Xcode should show you the new view, ready to edit.

//As with our other views, our first pass at AddView will be simple and we'll add to it. That means we're going to add text fields for the expense name and amount, plus a picker for the type, all wrapped up in a form and a navigation view.

//This should be old news to you by now, so let's get into the code:

/*
 struct AddView: View {
    @State private var name = ""
    @State private var type = "Personal"
    @State private var amount = ""
 
    static let types = ["Business", "Personal"]
 
    var body: some View {
        NavigationView {
            TextField("Name", text: $name)
            Picker("Type", selection: $type) {
                ForEach(Self.types, id: \.self) {
                    Text($0)
                }
            }
            TextField("Amount", text: $amount)
                .keyboardType(.numberPad)
        }
        .navigationBarTitle("Add new expense")
        }
    }
 }
 */

//We'll come back to that in a moment, but first let's add some code to COntentView so we can show AddView when the + button is tapped.

//In order to present AddView as a new view, we need to make three changes to ContentView. Firsst, we need some state to track whether or not AddView is being shown, so add this as a property now:

//@State private var showingAddExpense = false

//Next, we need to tell SwiftUI to use that Boolean as a condition for showing a sheet - a pop-up window. This is done by attaching the sheet() modifier somewhere to our view hierarchy. You can use the List if you want, but the NavigationView works just as well. Either way, add this code as a modifier to one of the views in ContentView:

/*
 .sheet(isPresented: $showingAddExpense) {
    AddView()
 }
 */


//Here, though, we need something more. You see, we already have the expenses property in our content view, and inside AddView we're going to be writing cofe to add expense items. We don't want to create a second instance of the Expenses class in AddView, but instead want it to cshare the existing instane from ContentView.

//So, what we're going to do is add a property to AddView to store an Expenses object. It won't create the object there, just say that it will exist. Please add this property to AddView:

//@ObservedObject var expenses: Expenses

//And now we can pass our existing Expenses object from one view to another - they will both share the same object, adn will both monitor it for changes. Modify your sheet() modifier in ContentView to this:

/*
 .sheet(isPresented: $showingAddExpense) {
    AddView(expenses: self.expenses)
 }
 
 */

//We're not quite done with this step yet, for two reasons: our code won't compile, and even if it did compile it wouldn't work because our button doesn't trigger the sheet.

//The compilation failure happens because when we made the new SwiftUI view, Xcode also added a preview provider so we can look at the design of the view while we were coding. If you find that down at the bottom of AddView.swift, you'll see that it tries to create an AddView instance without providing a value for the expenses property.

//That isn't allowed any more, but we can just pass in a dummy value instead, like this:

/*
 struct AddView_Previews: PreviewProvider {
    static var previews: some View {
        AddView(expenses: Expenses())
    }
 }
 */

//The second problem is that we don't actually have any code to show the sheet, because right now the + button in ContentView adds test expenses. Fortunately, the fix is trivial - just replace the existing action with coe to toggle our showingAddExpense Boolean, like this:

/*
 Button(action: {
    self.showingAddExpense = true
 }) {
    Image(systemName: "plus")
 }
 */

//If you run the app now the whole sheet should be working as intended - you start with ContentView, tap the + button to bring up an AddView where you can type the various fields, then can swipe to dismiss.
