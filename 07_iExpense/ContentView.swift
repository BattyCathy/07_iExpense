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
    @State private var showingAddExpense = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(expenses.items) { item in
                    Text(item.name)
                }
                .onDelete(perform: removeItems)
            }
            .sheet(isPresented: $showingAddExpense) {
                AddView(expenses: self.expenses)
            }
            .navigationBarTitle("iExpense")
            .navigationBarItems(trailing:
                                    Button(action: {
                                        self.showingAddExpense = true
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
