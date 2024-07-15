

import SwiftUI

// custom extensions

extension View {
    
    @ViewBuilder
    func hSpacing(_ alignment:Alignment) -> some View{
        self
            .frame(maxWidth: .infinity, alignment: alignment)
    }
    
    @ViewBuilder
    func vSpacing(_ alignment:Alignment) -> some View{
        self
            .frame(maxHeight: .infinity, alignment: alignment)
    }
    
    var safeArea: UIEdgeInsets {
        if let windowScene = (UIApplication.shared.connectedScenes.first as? UIWindowScene){
            return windowScene.keyWindow?.safeAreaInsets ?? .zero
        }
        return .zero
    }
    
    func formatt(date:Date, format:String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from:date)
    }
    
    func currencyString(_ value:Double, allowedDigits:Int = 2) -> String {
        let formatter = NumberFormatter()
        formatter.numberStyle = .currency
        formatter.currencyCode = "USD" // Set currency code to USD
        formatter.currencySymbol = "$" 
        formatter.maximumFractionDigits = allowedDigits
        return formatter.string(from: .init(value: value)) ?? ""
    }
    
//    func total(_ transactions:[Transaction], category: Category) -> Double {
//        return transactions.filter({ $0.category == category.rawValue  }).reduce(Double.zero){ partialResult, transaction in
//            return partialResult + transaction.amount
//        }
//    }
    
   
    
}
