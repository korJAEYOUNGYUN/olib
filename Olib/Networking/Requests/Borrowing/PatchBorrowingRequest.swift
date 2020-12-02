//
//  PatchBorrowingRequest.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/09.
//

import Foundation

class PatchBorrowingRequest: APIRequest {
    
    var path: String = "/api/libraries/"
    var method: HTTPMethod = .patch
    var accessToken: String?
    var needPermission: Bool = true
    let borrowing: Borrowing
    
    init(accessToken: String, borrowing: Borrowing) {
        self.accessToken = accessToken
        self.borrowing = borrowing
        path += "\(borrowing.id)/"
    }
    
    func body() -> Data? {
        return try? JSONEncoder().encode(borrowing)
    }
}
