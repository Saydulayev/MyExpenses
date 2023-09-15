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

    var totalExpense: Double {
        expenses.items.map { $0.amount }.reduce(0, +)
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List {
                    ForEach(expenses.items) { item in
                        HStack {
                            VStack(alignment: .leading) {
                                Text(item.name)
                                    .font(.headline)
                                Text(item.type)
                            }
                            Spacer()
                            
                            Text(item.amount, format: .currency(code: Locale.current.currency?.identifier ?? "USD"))
                                .foregroundColor(item.amount < 11 ? .green : (item.amount < 100 ? .orange : .red))
//                                .font(item.amount < 10 ? .headline.weight(.bold) : (item.amount >= 100 ? .headline.italic() : .headline))
                        }
                    }
                    .onDelete(perform: removeItems)
                }
                
                HStack {
                    Text("Total:")
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
    
    func removeItems(at offsets: IndexSet) {
        expenses.items.remove(atOffsets: offsets)
    }
}






struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
