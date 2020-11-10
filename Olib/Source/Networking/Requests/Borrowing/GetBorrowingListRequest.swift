//
//  GetBorrowingListRequest.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/09.
//

import Foundation

class GetBorrowingListRequest: APIRequest {
    
    var path: String = "/api/borrowings/"
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
