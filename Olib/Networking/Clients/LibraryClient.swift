//
//  LibraryClient.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/07.
//

import Foundation

struct LibraryClient {
        
    func getLibrary(accessToken: String, libraryId: Int, completion: @escaping (HTTPURLResponse, Data?) -> Void) {
        guard let request = GetLibraryRequest(accessToken: accessToken, libraryId: libraryId).request(for: URL(string: ServerManager.shared.serverURL)!) else {
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                return
            }
                        
            completion(response, data)
        }.resume()
    }
}
