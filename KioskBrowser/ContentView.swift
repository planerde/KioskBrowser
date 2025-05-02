//
//  ContentView.swift
//  KioskBrowser
//
//  Created by Tim Preuß on 11.03.23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("url") var url = "http://localhost:3000"
    
    @State private var IsLoading: Bool = false
    @State private var Error: Error?
    
    var body: some View {
        ZStack {
            WebView(url: url, isLoading: $IsLoading, error: $Error)
                .edgesIgnoringSafeArea([.bottom])
                .statusBar(hidden: true)
            
            ActivityIndicator(isAnimating: $IsLoading, style: .large)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
