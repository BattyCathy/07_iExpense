//
//  ExpenseItem.swift
//  07_iExpense
//
//  Created by Austin Roach on 2/9/21.
//

import Foundation

struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Int
}
