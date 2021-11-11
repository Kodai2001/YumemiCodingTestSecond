//
//  Repository.swift
//  YumemiCodingTest
//
//  Created by system on 2021/11/09.
//

import UIKit

struct Repository: Decodable {
    var items: [Item]
    
    struct Item: Decodable {
        var language: String?
        var fullName: String?
        var watchersCount: Int?
        var forksCount: Int?
        var openIssuesCount: Int?
        var starsCount: Int?
        var id: Int?
        var owner: owner?
        
        enum CodingKeys: String, CodingKey {
            case fullName = "full_name"
            case watchersCount = "watchers_count"
            case forksCount = "forks_count"
            case openIssuesCount = "open_issues_count"
            case starsCount = "stargazers_count"
            case language
            case id
            case owner
        }
        
        struct owner: Decodable {
            var avatarUrl: String?
            
            enum CodingKeys: String, CodingKey {
                case avatarUrl = "avatar_url"
            }
        }
    }
}




