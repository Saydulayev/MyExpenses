//
//  ContentView.swift
//  MyExpenses
//
//  Created by Akhmed on 14.09.23.
//

import SwiftUI

struct ContentView: View {
    
    @StateObject var expenses = Expenses()
    @State private var showingAddExpense = false

    var personalExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Personal" }
    }
    
    var businessExpenses: [ExpenseItem] {
        expenses.items.filter { $0.type == "Business" }
    }
    
    var totalExpense: Double {
        expenses.items.map { $0.amount }.reduce(0, +)
    }
    
    func totalExpense(for items: [ExpenseItem]) -> Double {
        items.map { $0.amount }.reduce(0, +)
    }
    
    var body: some View {
        NavigationView {
            ZStack {
                VStack {
                    List {
                        Section(
                            header: Text("Personal"),
                            footer: Text("Total: \(totalExpense(for: personalExpenses), format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                                .foregroundColor(.secondary)
                        ) {
                            ForEach(personalExpenses) { item in
                                expenseRow(for: item)
                            }
                            .onDelete(perform: { indexSet in
                                removeItems(at: indexSet, from: personalExpenses)
                            })
                        }

                        Section(
                            header: Text("Business"),
                            footer: Text("Total: \(totalExpense(for: businessExpenses), format: .currency(code: Locale.current.currency?.identifier ?? "USD"))")
                                .foregroundColor(.secondary)
                        ) {
                            ForEach(businessExpenses) { item in
                                expenseRow(for: item)
                            }
                            .onDelete(perform: { indexSet in
                                removeItems(at: indexSet, from: businessExpenses)
                            })
                        }
                    }
                    .listStyle(GroupedListStyle())
                    
                    HStack {
                        Text("TOTAL:")
                            .font(.headline)
                            
                        Spacer()
                        Text(totalExpense, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                            .font(.headline)
                            .foregroundColor(totalExpense < 11 ? .green : (totalExpense < 100 ? .orange : .red))
                            
                    }
                    .underline()
                    .padding()
                }
                .navigationTitle("MyExpenses")
                .toolbar {
                    Button {
                        showingAddExpense = true
                    } label: {
                        Image(systemName: "plus")
                    }
                }
                .sheet(isPresented: $showingAddExpense) {
                    AddView(expenses: expenses)
            }
            }
        }
    }
    
    func expenseRow(for item: ExpenseItem) -> some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.name)
                    .font(.headline)
                Text(item.type)
            }
            Spacer()
            
            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                .foregroundColor(item.amount < 11 ? .green : (item.amount < 100 ? .orange : .red))
        }
    }
    
    func removeItems(at offsets: IndexSet, from expenseArray: [ExpenseItem]) {
        for index in offsets {
            if let match = expenses.items.firstIndex(where: { $0.id == expenseArray[index].id }) {
                expenses.items.remove(at: match)
            }
        }
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
