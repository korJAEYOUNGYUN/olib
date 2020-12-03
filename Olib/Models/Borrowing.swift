//
//  Borrowing.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/09.
//

import Foundation

struct Borrowing: Codable {
    
    let id: Int
    let book: Book
    let user: Int
    let borrowed_at: String?
    let due: String?
    let returned_at: String?
    let is_returned: Bool?
    
    // for list
    static func parse(data: Data) -> [Borrowing] {
        var borrowingList = [Borrowing]()
        
        do {
            borrowingList = try JSONDecoder().decode([Borrowing].self, from: data)
        } catch {
            print(error)
        }
        
        return borrowingList
    }
}
