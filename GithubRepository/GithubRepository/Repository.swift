//
//  Repository.swift
//  GithubRepository
//
//  Created by Hyeongjung on 2022/11/16.
//

import Foundation

struct Repository: Decodable {
    let id: Int
    let name: String
    let description: String
    let stargazersCount: Int
    let language: String
    
    //표현하고 싶은 케이스와 키값이 다르기 때문에 CodingKeys를 통해 알려준다.
    enum CodingKeys: String, CodingKey {
        case id, name, description, language
        case stargazersCount = "stargazers_count"
    }
}
