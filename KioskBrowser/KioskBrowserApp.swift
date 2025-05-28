//
//  KioskBrowserApp.swift
//  KioskBrowser
//
//  Created by Tim Preuß on 11.03.23.
//

import SwiftUI

@main
struct KioskBrowserApp: App {
    init() {
        let clearCache = UserDefaults.standard.bool(forKey: "clear_cache")
        if clearCache {
            WebCacheCleaner.clean()
        }
        #if os(iOS)
            UIView.appearance().tintColor = UIColor(red: 0.549, green: 0.0, blue: 0.078, alpha: 1.0)  // #8C0014
        #endif
    }

    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
