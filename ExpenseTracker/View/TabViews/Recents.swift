//
//  Recents.swift
//  ExpenseTracker
//
//  Created by Denilson Washuma on 06/07/2024.
//

import SwiftUI
import SwiftData

struct Recents: View {
    
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endOfMonth
    @State private var showDateFilter = false
    @State private var selectedCategory: Category = .income
    //for animation
    @Namespace private var animation
    //Read data from swift data
    @Query(sort: [SortDescriptor(\Transaction.dateCreated, order: .reverse)], animation: .snappy) private var transactions:[Transaction]
    var body: some View {
        GeometryReader {
            let size = $0.size //for animation
            
            NavigationStack{
                ScrollView(.vertical) {
                    LazyVStack(spacing:10,pinnedViews: [.sectionHeaders]) {
                        Section {
                            //date filter button
                            Button(action: {
                                showDateFilter = true
                            }, label: {
                                Text("\(formatt(date:startDate,format:"dd-MMM yy")) to \(formatt(date:endDate,format:"dd-MMM yy"))")
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                            })
                            .hSpacing(.leading)
                            
                           
                       CardView(income: 2030, expense: 4098)
                                
                        CustomSegmentedCtrl()
                                
                         ForEach(transactions.filter({ $0.category == selectedCategory.rawValue })) { transaction in
                                    
                                    NavigationLink{
                                        NewExpenseView(editTransaction: transaction)
                                    } label: {
                                        TransactionCard(transaction: transaction)
                                    }
                                    
                                }
                        
                         
                        } header: {
                            HeaderView(size)
                            
                        }
                        
                    }
                    .padding()
                }
                .background(.gray.opacity(0.15))
                .blur(radius: showDateFilter ? 10 :0 )
                .disabled(showDateFilter)
            }
            .overlay {
            
                    if showDateFilter {
                        DateFilterView(start:startDate, end: endDate, onSubmit: { start, end in
                            startDate = start
                            endDate = end
                            showDateFilter = false
                        }, onClose: {
                            showDateFilter = false
                        })
                            .transition(.move(edge: .leading))
                    }
               
                
            }
            .animation(.snappy,value: showDateFilter)
            
            
            
        }
    }
    //Segmented Control
    @ViewBuilder
    func CustomSegmentedCtrl() -> some View {
        HStack(spacing:0){
            ForEach(Category.allCases,id:\.rawValue) { category in
                Text(category.rawValue.capitalized)
                    .hSpacing(.center)
                    .padding(.vertical,10)
                    .background {
                        if category == selectedCategory{
                            Capsule()
                                .fill(.background)
                                .matchedGeometryEffect(id: "ACTIVETAB", in: animation)
                        }
                        
                    }
                    .contentShape(.capsule)
                    .onTapGesture {
                        withAnimation(.snappy){
                            selectedCategory = category
                        }
                    }
                
            }
            
        }
        .background(.gray.opacity(0.15), in:.capsule)
        .padding(.top,5)
        .padding(.bottom,10)
        
    }
    
    //Header
    @ViewBuilder
    func HeaderView(_ size: CGSize) -> some View {
        
        HStack(spacing:10){
            VStack(alignment: .leading, spacing: 5, content: {
                Text("Welcome!")
                    .font(.title.bold())
            })
            
            Spacer()
            
            NavigationLink {
                NewExpenseView()
            } label: {
                Image(systemName: "plus")
                    .font(.title3)
                    .fontWeight(.semibold)
                    .foregroundStyle(.white)
                    .frame(width: 45,height: 45)
                    .background(appTint.gradient,in:.circle)
                    .contentShape(.circle)
            }
            
        }
        .padding(.bottom,5)
        .background{
            
            Rectangle()
                .fill(.ultraThinMaterial)
                .visualEffect { content, geometryProxy in
                    //show background when it starts to scroll: https://youtu.be/TXJF8fkOp4c?t=467
                    content.opacity(headerBgOpacity(geometryProxy))
                }
                .padding(.horizontal,-15)
                .padding(.top,-(safeArea.top + 15))
            
            
            
        }
    }
    func headerBgOpacity(_ proxy: GeometryProxy) -> CGFloat {
        let minY = proxy.frame(in: .scrollView).minY + safeArea.top
        
        return minY > 0 ? 0 : (-minY / 15)
    }
    
}

#Preview {
    ContentView()
}
