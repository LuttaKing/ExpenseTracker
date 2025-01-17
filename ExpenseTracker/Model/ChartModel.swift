//
//  ChartModel.swift
//  ExpenseTracker
//
//  Created by Denilson Washuma on 08/07/2024.
//

import SwiftUI

struct ChartGroup: Identifiable {
    let id: UUID = .init()
    var date:Date
    var categories:[ChartCategory]
    var totalIncome:Double
    var totalExpense:Double
}

struct ChartCategory: Identifiable {
    let id: UUID = .init()
    var totalValue:Double
    var category: Category
}
