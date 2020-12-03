//
//  ServerManager.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/03.
//

import Foundation

class ServerManager {
    
    static let shared = ServerManager()
    
    // server url to communicate for api
    var serverURL: String = "http://127.0.0.1:8000"
}
