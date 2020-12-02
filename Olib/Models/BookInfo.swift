//
//  BookInfo.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/06.
//

import Foundation

struct BookInfo: Codable {
    
    let id: Int
    let isbn: String
    let title: String
    let author: String
    let publisher: String
    let published_year: String
    let category: String
}
