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
        
        if (clearCache)
        {
            WebCacheCleaner.clean();
        }
        
        
    }
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
