//
//  Book.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/05.
//

import Foundation

struct Book: Codable {
    
    let id: Int
    let library: Library
    let location: String
    let is_available: Bool
    let book_info: BookInfo
}
