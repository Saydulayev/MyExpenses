//
//  Expenses.swift
//  MyExpenses
//
//  Created by Akhmed on 14.09.23.
//

import Foundation


class Expenses: ObservableObject {
    @Published var items = [ExpenseItem]()
}
