//
//  ExpenseItem.swift
//  MyExpenses
//
//  Created by Akhmed on 14.09.23.
//

import Foundation


struct ExpenseItem: Identifiable {
    let id = UUID()
    let name: String
    let type: String
    let amount: Double
}
