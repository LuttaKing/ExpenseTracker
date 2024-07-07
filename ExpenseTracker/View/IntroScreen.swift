//
//  IntroScreen.swift
//  ExpenseTracker
//
//  Created by Denilson Washuma on 06/07/2024.
//

import SwiftUI

struct IntroScreen: View {
    
    @AppStorage("isFirstLaunch") private var isFirstLaunch = true
    var body: some View {
        VStack(spacing:15) {
            
            Text("What's new in the \nExpense tracker")
                .font(.largeTitle.bold())
                .multilineTextAlignment(.center)
                .padding(.top,65)
                .padding(.bottom,35)
            
            VStack(alignment: .leading, spacing: 25, content: {
                PointView(symbol: "dollarsign", title: "Transaction", subTitle:"Keep track of your earnings and expenses")
                
                PointView(symbol: "chart.bar", title: "Visual Charts", subTitle:"Cool charts of your earnings and expenses")
                PointView(symbol: "magnifyingglass", title: "Cool Filters", subTitle:"Keep track of your earnings and expenses")
              
            })
            .frame(maxWidth: .infinity,alignment: .leading)
            .padding(.horizontal,25)
            
            Spacer()
            
            Button("Continue") {
                isFirstLaunch = false
            }
           .fontWeight(.bold)
            .foregroundStyle(.white)
            
            .frame(maxWidth: .infinity)
            .padding(.vertical)
            .background(appTint.gradient)
            .cornerRadius(12)
            .padding()
            
            
            
        }
    }
    
    //Point View
    @ViewBuilder
    func PointView(symbol: String, title:String, subTitle:String) -> some View {
        HStack(spacing: 15, content: {
            
            Image(systemName: symbol)
                .font(.largeTitle)
                .foregroundStyle(appTint)
                .frame(width: 45)
            
            VStack(alignment: .leading,spacing: 6, content: {
                Text(title)
                    .font(.title3.weight(.semibold))
                
                Text(subTitle)
                    .foregroundStyle(.gray)
                
            })
            
            
        })
        
    }
    
    
}

#Preview {
    IntroScreen()
}
