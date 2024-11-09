//
//  DetailsWebView.swift
//  NewsReader
//
//  Created by Mayur on 10/11/24.
//

import SwiftUI
import WebKit

struct DetailsWebView: UIViewRepresentable {
    let url: String?

    init(_ url: String?) {
        self.url = url
    }

    func makeUIView(context: Context) -> WKWebView {
        return WKWebView()
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        if let url = URL(string: url!) {
            let request = URLRequest(url: url)
            DispatchQueue.main.async {
                uiView.load(request)
            }
        }
    }
}
