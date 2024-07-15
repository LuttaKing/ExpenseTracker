//
//  Search.swift
//  ExpenseTracker
//
//  Created by Denilson Washuma on 06/07/2024.
//

import SwiftUI
import Combine
import SwiftData

struct Search: View {
    @State private var searchText: String = ""
    @State private var filterText: String = ""
    let searchPublisher = PassthroughSubject<String,Never>() // import combine
    
    //Read data from swift data
    @Query(sort: [SortDescriptor(\Transaction.dateCreated, order: .reverse)], animation: .snappy) private var transactions:[Transaction]
    
    var searchResults:[Transaction] {
        return transactions.filter{
            $0.title.contains(filterText)
        }
    }
    
    var body: some View {
        NavigationStack{
            ScrollView(.vertical){
                LazyVStack(spacing:12){
                    ForEach(searchResults) { transaction in
                               
                               NavigationLink{
                                   NewExpenseView(editTransaction: transaction)
                               } label: {
                                   TransactionCard(transaction: transaction)
                               }
                               
                           }
                    
                }
            }
            .overlay{
                ContentUnavailableView("Search Transaction",systemImage: "magnifyingglass")
                    .opacity(filterText.isEmpty ? 1 : 0)
            }
            .padding()
            .background(.gray.opacity(0.15))
            .onChange(of: searchText, { oldValue, newValue in
                //We use 'Import Combine' to reduce update frequency
                searchPublisher.send(newValue)
                //instead of using searchText directly, use onRecieve below
            })
            .onReceive(searchPublisher.debounce(for: .seconds(0.3), scheduler: DispatchQueue.main),
                       perform: { text in
                filterText = text
                //change is only published after a .3 seconds wait
            
            })
            .searchable(text: $searchText)
            .navigationTitle("Search")
        }
    }
}

#Preview {
    Search()
}
