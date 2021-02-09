//
//  Expenses.swift
//  07_iExpense
//
//  Created by Austin Roach on 2/9/21.
//

import Foundation

class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}
