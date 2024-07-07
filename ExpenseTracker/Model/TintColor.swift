//
//  TintColor.swift
//  ExpenseTracker
//
//  Created by Denilson Washuma on 06/07/2024.
//

import SwiftUI

struct TintColor:Identifiable{
    let id:UUID = UUID() //or .init
    var color:String
    var value:Color
    
    
}

var tints: [TintColor] = [
    .init(color: "Red", value: .red),
    .init(color: "Blue", value: .blue),
    .init(color: "Purple", value: .purple),
    TintColor(color: "Orange", value: .orange),
    TintColor(color: "Brown", value: .brown)
    
]
