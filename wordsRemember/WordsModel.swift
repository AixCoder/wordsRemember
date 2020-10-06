//
//  WordsModel.swift
//  wordsRemember
//
//  Created by liuhongnian on 2020/10/2.
//  Copyright © 2020 liuhongnian. All rights reserved.
//

import UIKit

class WordsModel: Codable {
    
    let hitokoto: String
    let from: String
    let creator: String
    let reviewer: Int
    let commitFrom: String
    let createdAt: String
    let length: Int
    
    private enum CodingKeys: String, CodingKey {
        case hitokoto
        case from
        case creator
        case reviewer
        case commitFrom = "commit_from"
        case createdAt = "created_at"
        case length
    }
    
    
}
