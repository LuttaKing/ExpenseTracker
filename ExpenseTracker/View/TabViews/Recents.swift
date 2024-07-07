//
//  Recents.swift
//  ExpenseTracker
//
//  Created by Denilson Washuma on 06/07/2024.
//

import SwiftUI

struct Recents: View {
    
    @State private var startDate: Date = .now.startOfMonth
    @State private var endDate: Date = .now.endOfMonth
    var body: some View {
        GeometryReader {
            let size = $0.size //for animation
            
            NavigationStack{
                ScrollView(.vertical) {
                    LazyVStack(spacing:10,pinnedViews: [.sectionHeaders]) {
                        Section {
                            //date filter button
                            Button(action: {
                                
                            }, label: {
                                Text("\(formatt(date:startDate,format:"dd-MMM yy")) to \(formatt(date:endDate,format:"dd-MMM yy"))")
                                    .font(.caption2)
                                    .foregroundStyle(.gray)
                            })
                            .hSpacing(.leading)
                            
                            //CardView
                            
                            
                        } header: {
                            HeaderView(size)
                            
                        }

                    }
                    .padding()
                }
            }
            
            
        }
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
