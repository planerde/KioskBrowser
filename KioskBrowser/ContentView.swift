//
//  ContentView.swift
//  KioskBrowser
//
//  Created by Tim Preuß on 11.03.23.
//

import SwiftUI

struct ContentView: View {
    
    @AppStorage("url") var url = "https://www.example.com"
    
    var body: some View {
        WebView(url: url)
            .edgesIgnoringSafeArea([.bottom])
            .statusBar(hidden: true)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
