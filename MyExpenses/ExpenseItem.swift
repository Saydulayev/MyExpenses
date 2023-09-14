//
//  ExpenseItem.swift
//  MyExpenses
//
//  Created by Akhmed on 14.09.23.
//

import Foundation


struct ExpenseItem: Identifiable, Codable {
    var id = UUID()
    let name: String
    let type: String
    let amount: Double
}
