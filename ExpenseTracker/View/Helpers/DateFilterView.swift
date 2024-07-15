//
//  DateFilterView.swift
//  ExpenseTracker
//
//  Created by Denilson Washuma on 07/07/2024.
//

import SwiftUI

struct DateFilterView: View {
    
    @State var start: Date
    @State var end: Date
    var onSubmit: (Date,Date) -> () //when submit is clicked, it returns both dates
    var onClose: () -> ()
    
    var body: some View {
        VStack(spacing:15){
            DatePicker("Start Date", selection: $start,displayedComponents: [.date])
            
            DatePicker("End Date", selection: $end,displayedComponents: [.date])
            
            HStack(spacing:15){
                
                Button("Cancel"){
                    onClose()
                }
                .buttonStyle(.borderedProminent)
                .tint(.red)
                
                Button("Filter"){
                    onSubmit(start,end)
                }
                .buttonStyle(.borderedProminent)
                .tint(appTint)
                
            }
            .padding(.top,10)
        }
        .padding(15)
        .background(.bar, in: .rect(cornerRadius: 10))
        .padding(.horizontal,30)
    }
}

