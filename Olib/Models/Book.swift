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
    
    // for list
    static func parse(data: Data) -> [Book] {
        do {
            let bookList = JSONDecoder().decode([Book].self, from: data)
        } catch {
            print(error)
        }
        
        return bookList
    }
    
    // for retrieve
    static func parse(data: Data) -> Book {
        do {
            let book = JSONDecoder().decode(Book.self, from: data)
        } catch {
            print(error)
        }
        
        return book
    }
}
