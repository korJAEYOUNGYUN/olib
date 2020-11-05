//
//  BookInfoRequest.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/05.
//

import Foundation

class BookInfoRequest: APIRequest {
    
    var path: String = "/api/books/"
    var method: HTTPMethod = .get
    var accessToken: String?
    var needPermission: Bool = true
    
    init(accessToken: String, bookId: Int) {
        self.accessToken = accessToken
        path += "\(bookId)/"
    }
    
    func body() -> Data? {
        return nil
    }
}
