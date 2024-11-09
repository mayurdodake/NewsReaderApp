//
//  NewsArticleDetailsView.swift
//  NewsReader
//
//  Created by Mayur on 10/11/24.
//

import SwiftUI

struct NewsArticleDetailsView: View {
    var article: NewsArticle?

    var body: some View {
        DetailsWebView(article?.url)
            .padding()
            .navigationTitle(article?.title ?? "")
            .navigationBarTitleDisplayMode(.inline)
    }
}


struct NewsArticleDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        NewsArticleDetailsView()
    }
}
