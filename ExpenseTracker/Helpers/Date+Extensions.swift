//
//  Date+Extensions.swift
//  ExpenseTracker
//
//  Created by Denilson Washuma on 07/07/2024.
//

import SwiftUI

extension Date {
    var startOfMonth:Date {
        let calender = Calendar.current
        let components = calender.dateComponents([.year,.month], from: self)
        return calender.date(from: components) ?? self
        
    }
    
    var endOfMonth:Date {
        let calender = Calendar.current
        return calender.date(byAdding: .init(month:1,minute: -1), to: self.startOfMonth) ?? self
    }
}
