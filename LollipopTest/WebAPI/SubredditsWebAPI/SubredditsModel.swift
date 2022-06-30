//
//  Subreddits.swift
//  LollipopTest
//
//  Created by 劉柏賢 on 2022/6/27.
//

import Foundation

struct SubredditsModel: Decodable {
    let data: Data
}

extension SubredditsModel {
    struct Data: Decodable {
        let children: [Children]
    }
}

extension SubredditsModel.Data {
    struct Children: Decodable {
        struct Data: Decodable {
            let display_name: String
        }

        let data: Data
    }
}

