//
//  Transaction.swift
//  ExpenseTracker
//
//  Created by Denilson Washuma on 06/07/2024.
//

import SwiftUI

struct Transaction: Identifiable {
    let id: UUID = .init()
    
    var title:String
    var remark:String
    var amount:Double
    var dateCreated: Date
    var category: String
    var tintColor: String
    
    init(title: String, remark: String, amount: Double, dateCreated: Date, category: Category, tintColor: TintColor) {
        self.title = title
        self.remark = remark
        self.amount = amount
        self.dateCreated = dateCreated
        self.category = category.rawValue
        self.tintColor = tintColor.color
    }
    
    var color: Color {
        tints.first(where: { $0.color == tintColor })?.value ?? appTint
    }
    
    
    
    
}

