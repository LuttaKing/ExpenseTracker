//
//  ContentView.swift
//  ExpenseTracker
//
//  Created by Denilson Washuma on 06/07/2024.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("isFirstLaunch") private var isFirstLaunch = true
    //Active tab
    @State private var activeTab: Tab = .recents
    
    var body: some View {
        TabView(selection:$activeTab){
            Text("Recents")
                .tag(Tab.recents)
                .tabItem { Tab.recents.tabContent }
            
            Text("Search")
                .tag(Tab.search)
                .tabItem { Tab.search.tabContent }
            
            Text("Chart")
                .tag(Tab.charts)
                .tabItem { Tab.charts.tabContent }
            
            Text("Settings")
                .tag(Tab.settings)
                .tabItem { Tab.settings.tabContent }
            
            
        }
        .tint(appTint)
        .sheet(isPresented: $isFirstLaunch, content: {
            IntroScreen().interactiveDismissDisabled()
        })
    }
}

#Preview {
    ContentView()
}
