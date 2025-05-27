//
//  ContentView.swift
//  KioskBrowser
//
//  Created by Tim Preuß on 11.03.23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("URL") var url = (Bundle.main.path(forResource: "tutorial", ofType: "html") ?? "")
    
    @State private var IsLoading: Bool = false
    @State private var Error: Error?
    
    var body: some View {
        ZStack {
            WebView(url: URL(fileURLWithPath: url).absoluteString, isLoading: $IsLoading, error: $Error)
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
