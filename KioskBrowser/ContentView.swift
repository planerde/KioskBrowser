//
//  ContentView.swift
//  KioskBrowser
//
//  Created by Tim Preuß on 11.03.23.
//

import SwiftUI
import WebKit

struct ContentView: View {
    @AppStorage("url") private var url: String = ""
    @State private var isLoading: Bool = false
    @State private var error: Error?
    @State private var showSettings: Bool = false
    @State private var webViewReloadTrigger: Bool = false

    var body: some View {
        ZStack {
            if !url.isEmpty {
                WebView(url: url, isLoading: $isLoading, error: $error)
                    .id(webViewReloadTrigger ? 1 : 0)  // force reload on trigger
            }
            ActivityIndicator(isAnimating: $isLoading, style: .large)
        }
        .onAppear {
            if url.isEmpty {
                showSettings = true
            }
        }
        .sheet(
            isPresented: $showSettings,
            onDismiss: {
                // Reload WebView after settings are changed
                webViewReloadTrigger.toggle()
            }
        ) {
            SettingsView {
                showSettings = false
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
