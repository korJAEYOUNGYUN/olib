//
//  LibraryRequest.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/07.
//

import Foundation

class GetLibraryRequest: APIRequest {
    
    var path: String = "/api/libraries/"
    var method: HTTPMethod = .get
    var accessToken: String?
    var needPermission: Bool = true
    
    init(accessToken: String, libraryId: Int) {
        self.accessToken = accessToken
        path += "\(libraryId)/"
    }
    
    func body() -> Data? {
        return nil
    }
}
