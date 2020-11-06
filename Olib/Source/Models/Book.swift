//
//  Book.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/05.
//

import Foundation

struct Book: Decodable {
    
    let id: Int
    let library: Int
    let location: String
    let is_available: Bool
    let book_info: Int
    let due: String?
}
