//
//  BookInfoRequest.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/05.
//

import Foundation

class GetBookInfoRequest: APIRequest {
    
    var path: String = "/api/bookinfos/"
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
