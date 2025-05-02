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
    
    @AppStorage("ReloadAfterErrorInSeconds") var ReloadAfterErrorInSeconds : Int = 3
    
    @Binding var isLoading: Bool
    @Binding var error: Error?
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    init(url: String, isLoading: Binding<Bool>, error: Binding<Error?>) {
        self.url = url
        _isLoading = isLoading
        _error = error
    }
    
    func makeUIView(context: Context) -> WKWebView {
        guard let url = URL(string: self.url) else {
            return WKWebView();
        }
        
        let preferences = WKPreferences()
        let configuration = WKWebViewConfiguration()
        configuration.preferences = preferences
        configuration.allowsInlineMediaPlayback = true;
        
        let request = URLRequest(url: url)
        let wkWebView = WKWebView()
        wkWebView.load(request)
        wkWebView.allowsBackForwardNavigationGestures = false
        wkWebView.allowsLinkPreview = false
        wkWebView.scrollView.contentInsetAdjustmentBehavior = .never
        wkWebView.navigationDelegate = context.coordinator
        wkWebView.uiDelegate = context.coordinator
        
        return wkWebView
    }
    
    func updateUIView(_ uiView: WKWebView, context: UIViewRepresentableContext<WebView>) {
    }
    
    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        var parent: WebView

        init(_ parent: WebView) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
        }
        
        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            
        }
        
        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
              parent.isLoading = false
              parent.error = error
            
                DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(self.parent.ReloadAfterErrorInSeconds)) {
                    let request = URLRequest(url: URL(string: self.parent.url)!)
                    webView.load(request)
                }
                
        }
        
        @available(iOS 15.0, *)
        @available(macOS 12.0, *)
        func webView(_ webView: WKWebView, decideMediaCapturePermissionsFor origin: WKSecurityOrigin, initiatedBy frame: WKFrameInfo, type: WKMediaCaptureType) async -> WKPermissionDecision {
                return .grant;
        }
    }
}
