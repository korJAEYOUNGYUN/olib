//
//  BookClient.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/05.
//

import Foundation

struct BooksClient {
        
    func searchBooks(accessToken: String, queries: [String: String]?, completion: @escaping (HTTPURLResponse, Data?) -> Void) {
        guard let request = BookListRequest(accessToken: accessToken).request(for: URL(string: ServerManager.shared.serverURL)!, with: queries) else {
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                return
            }
                        
            completion(response, data)
        }.resume()
    }
    
    func bookInfo(accessToken: String, bookId: Int, completion: @escaping (HTTPURLResponse, Data?) -> Void) {
        guard let request = BookInfoRequest(accessToken: accessToken, bookId: bookId).request(for: URL(string: ServerManager.shared.serverURL)!) else {
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
