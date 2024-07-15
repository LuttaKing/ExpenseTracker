//
//  NewExpenseView.swift
//  ExpenseTracker
//
//  Created by Denilson Washuma on 09/07/2024.
//

import SwiftUI

struct NewExpenseView: View {
    
    @State private var isShowingPopup = false

    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var title:String = ""
    @State private var remarks:String = ""
    @State private var amount:Double = .zero
    @State private var dateAdded :Date = .now
    @State private var category:Category = .expense
    
    //for editing puproses
     var editTransaction:Transaction?
    
    var tint:TintColor = tints.randomElement()!
    var body: some View {
        ScrollView(.vertical) {
            VStack{
                Text("preview")
                    .font(.caption)
                    .foregroundStyle(.gray)
                    .hSpacing(.leading)
                    .padding(.bottom,5)
                
                //
                TransactionCard(transaction: Transaction(title:title.isEmpty ?"Enter title": title, remark: remarks.isEmpty ? "Enter Remarks" : remarks, amount: amount, dateCreated: dateAdded, category: category, tintColor: tint))
                
                
                CustomView(title: $title,head:"Title")
                CustomView(title: $remarks, head: "Remarks")
                
                VStack(alignment: .leading, spacing: 10, content: {
                    Text("Amount & Category")
                        .font(.caption)
                        .foregroundStyle(.gray)
                        .hSpacing(.leading)
                    HStack(spacing:15){
                        TextField("0.0", value: $amount, formatter: numberFormatter)
                            .padding(.horizontal,15)
                            .padding(.vertical, 12)
                            .background(.background, in: .rect(cornerRadius: 10))
                            .frame(maxWidth: 130)
                            .keyboardType(.decimalPad)
                        
                        //Custom CheckBox
                        HStack(spacing:5) {
                            ForEach(Category.allCases, id:\.rawValue){ category in
                                HStack(spacing: 5, content: {
                                    ZStack{
                                        Image(systemName: "circle")
                                            .font(.title3)
                                            .foregroundStyle(appTint)
                                        
                                        if self.category == category{
                                            Image(systemName: "circle.fill")
                                                .font(.caption)
                                                .foregroundStyle(appTint)
                                        }
                                    }
                                    Text(category.rawValue)
                                })
                                .contentShape(.rect)
                                .onTapGesture {
                                    self.category = category
                                }
                            }
                            
                        }
                        .padding(.horizontal,15)
                        .padding(.vertical,12)
                        .hSpacing(.leading)
                        .background(.background,in: .rect(cornerRadius:10))
                    }
                })
                
                
                if let editTransaction{
                    Button {
                        deleteTransaction(transaction: editTransaction)
                    } label: {
                        Text("Delete Transaction")
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                            .padding(.vertical,12)
                            .padding(.horizontal,100)
                            .background(.red)
                            .cornerRadius(10)
                    }
                    .padding(.top,20)
                }
               

                
                
                
                
            }
            .padding(15)
            
        }
        .navigationTitle(editTransaction != nil ? "Update Transaction" :"Add Transaction")
        .background(.gray.opacity(0.15))
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                if  editTransaction != nil{
                    Button("Update", action: updateTransaction)
                } else {
                    Button("Save", action: save)
                }
                
            }
        }
        .onAppear {
            //load all data from editTransaction
            if let editTransaction  {
                title = editTransaction.title
                remarks = editTransaction.remark
                amount = editTransaction.amount
                dateAdded = editTransaction.dateCreated
                if editTransaction.category.lowercased().contains("income"){
                    category = .income
                } else{
                    category = .expense
                }
            }
        }
        .alert(isPresented: $isShowingPopup) {
                    Alert(
                        title: Text("Fill the Form"),
                        message: Text("Enter title and amount"),
                        dismissButton: .default(Text("OK"))
                    )
                }
    }
    //save item to SwiftData
    func save(){
        if title.isEmpty || amount.isZero {
            isShowingPopup = true
        } else {
            let transaction = Transaction(title: title, remark: remarks, amount: amount, dateCreated: dateAdded, category: category, tintColor: tint)
            modelContext.insert(transaction)
            //close the view
            dismiss()
        }
      
        
    }
    
    func deleteTransaction(transaction:Transaction){
        modelContext.delete(transaction)
        
        dismiss()
    }
    
    func updateTransaction(){
        editTransaction?.title = title
        editTransaction?.remark = remarks
        editTransaction?.amount = amount
        editTransaction?.dateCreated = dateAdded
        editTransaction?.category = category.rawValue

       
        
       try? modelContext.save()
        
        dismiss()
    }
    
    var numberFormatter:NumberFormatter {
        let formatter = NumberFormatter()
        formatter.numberStyle = .decimal
        formatter.maximumFractionDigits = 2
        
        return formatter
    }
}

#Preview {
    NavigationStack{
        NewExpenseView()
    }
    
}

struct CustomView: View {
    @Binding var title: String
    var head:String
    var body: some View {
        VStack(alignment: .leading,spacing: 10, content: {
            Text(head.capitalized)
                .font(.caption)
                .foregroundStyle(.gray)
                .hSpacing(.leading)
                .padding(.top,5)
            
            TextField("Enter some text", text: $title)
                .padding(.horizontal,15)
                .padding(.vertical, 12)
                .background(.background, in: .rect(cornerRadius: 10))
        })
    }
}
