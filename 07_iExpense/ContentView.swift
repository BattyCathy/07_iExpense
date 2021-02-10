//
//  ContentView.swift
//  07_iExpense
//
//  Created by Austin Roach on 2/6/21.
//

import SwiftUI

struct User: Codable {
    var firstName: String
    var lastName: String
}

struct ContentView: View {
    
    @ObservedObject var expenses = Expenses()
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items, id: \.id) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        let expense = ExpenseItem(name: "Test", type: "Personal", amount: 5)
                                        self.expenses.items.append(expense)
                                    }) {
                                        Image(systemName: "plus")
                                    }
            )
        }
    }
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}
