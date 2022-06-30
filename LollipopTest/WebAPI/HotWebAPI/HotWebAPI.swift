//
//  HotWebAPI.swift
//  LollipopTest
//
//  Created by 劉柏賢 on 2022/6/25.
//

import Foundation

struct HotWebAPI: HTTPGet {

    typealias Parameter = HotParameter
    typealias Model = HotModel
    
    let urlString: String = "https://www.reddit.com/r/%@/hot.json"
    
    func invokeAsync(_ parameter: HotParameter) async throws -> HotModel {
        let urlString = String(format: urlString, parameter.subreddit)

        var urlComponent = URLComponents(string: urlString)
        urlComponent?.queryItems = [
            URLQueryItem(name: "count", value: "\(parameter.count)"),
            URLQueryItem(name: "after", value: "\(parameter.after)"),
            URLQueryItem(name: "limit", value: "\(parameter.limit)")
        ]

        return try await get(parameter, urlComponent?.url)
    }
}
