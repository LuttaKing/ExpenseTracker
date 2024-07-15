//
//  Settings.swift
//  ExpenseTracker
//
//  Created by Denilson Washuma on 06/07/2024.
//

import SwiftUI

struct Settings: View {
    //
    @State private var username = ""
    @AppStorage("isAppLockEnabled") private var isAppLockEnabled:Bool = false
    @AppStorage("lockWhenAppGoesBackground") private var lockWhenAppGoesBackground:Bool = false
    var body: some View {
        NavigationStack{
            List{
                Section("Settings") {
                    TextField("iJustine", text: $username)
                }
                Section("Lock"){
                    Toggle("Enable App Lock",isOn: $isAppLockEnabled)
                    
                    if isAppLockEnabled {
                        Toggle("Lock when in background",isOn: $lockWhenAppGoesBackground)
                        
                    }
                }
                
            }
            .navigationTitle("Settings")
        }
    }
}

#Preview {
    Settings()
}
