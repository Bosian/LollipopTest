//
//  SubredditsWebAPI.swift
//  LollipopTest
//
//  Created by 劉柏賢 on 2022/6/25.
//

import Foundation

struct SubredditsWebAPI: HTTPGet {

    typealias Parameter = SubredditsParameter
    typealias Model = SubredditsModel

    let urlString: String = "https://www.reddit.com/subreddits/default.json"
}
