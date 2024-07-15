//
//  TransactionCard.swift
//  ExpenseTracker
//
//  Created by Denilson Washuma on 07/07/2024.
//

import SwiftUI

struct TransactionCard: View {
    var transaction:Transaction
    var body: some View {
        
            HStack(spacing:12){
                Text("\(String(transaction.title.prefix(1)))")
                    .font(/*@START_MENU_TOKEN@*/.title/*@END_MENU_TOKEN@*/)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 45,height: 45)
                    .background(transaction.color.gradient,in:.circle)
                
                VStack(alignment: .leading,spacing: 4){
                    Text(transaction.title)
                        .foregroundStyle(.black)
                    
                    Text(transaction.remark)
                        .font(.caption)
                        .foregroundStyle(.black.secondary)
                    
                    Text(formatt(date:transaction.dateCreated,format:"dd MMM yyyy"))
                        .font(.caption2)
                        .foregroundStyle(.gray)
                    
                }
                .lineLimit(1)
                .hSpacing(.leading)
                
                Text(currencyString(transaction.amount,allowedDigits:1))
                    .fontWeight(.semibold)
                    .foregroundStyle(.black)
                
            }
            .padding(.horizontal,15)
            .padding(.vertical,10)
            .background(.background,in:.rect(cornerRadius: 10))
      
    }
}

#Preview {
    ContentView()
}
