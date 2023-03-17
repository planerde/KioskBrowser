//
//  WebView.swift
//  KioskBrowser
//
//  Created by Tim Preuß on 11.03.23.
//

import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    typealias UIViewType = WKWebView
    
    var url: String
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url) else {
            return WKWebView();
        }
              
        let request = URLRequest(url: url)
        let wkWebView = WKWebView()
        wkWebView.load(request)
        wkWebView.allowsBackForwardNavigationGestures = false
        wkWebView.allowsLinkPreview = false
        wkWebView.scrollView.contentInsetAdjustmentBehavior = .never
        
        return wkWebView
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
      
    }
}
