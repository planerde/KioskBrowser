//
//  WebCacheCleaner.swift
//  KioskBrowser
//
//  Created by Tim Preuß on 11.03.23.
//

import Foundation
import WebKit


// found on https://gist.github.com/insidegui/4a5de215a920885e0f36294d51263a15
final class WebCacheCleaner {
    
    class func clean() {
        HTTPCookieStorage.shared.removeCookies(since: Date.distantPast)
        print("[WebCacheCleaner] All cookies deleted")
        
        WKWebsiteDataStore.default().fetchDataRecords(ofTypes: WKWebsiteDataStore.allWebsiteDataTypes()) { records in
            records.forEach { record in
                WKWebsiteDataStore.default().removeData(ofTypes: record.dataTypes, for: [record], completionHandler: {})
                print("[WebCacheCleaner] Record \(record) deleted")
            }
        }
    }
    
}
