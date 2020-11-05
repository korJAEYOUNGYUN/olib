//
//  BookListRequest.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/05.
//

import Foundation

class BookListRequest: APIRequest {
    
    var path: String = "/api/books/"
    var method: HTTPMethod = .get
    var accessToken: String?
    var needPermission: Bool = true
    
    init(accessToken: String) {
        self.accessToken = accessToken
    }
    
    func body() -> Data? {
        return nil
    }
}
