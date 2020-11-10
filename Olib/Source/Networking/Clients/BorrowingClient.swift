//
//  BorrowingClient.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/11/09.
//

import Foundation

struct BorrowingClient {
    
    func getBorrowingList(accessToken: String, queries: [String: String]?, completion: @escaping (HTTPURLResponse, Data?) -> Void) {
        guard let request = GetBorrowingListRequest(accessToken: accessToken).request(for: URL(string: ServerManager.shared.serverURL)!, with: queries) else {
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                return
            }
                        
            completion(response, data)
        }.resume()
    }
    
    func createBorrowing(accessToken: String, borrowing: Borrowing, completion: @escaping (HTTPURLResponse, Data?) -> Void) {
        guard let request = PostBorrowingRequest(accessToken: accessToken, borrowing: borrowing).request(for: URL(string: ServerManager.shared.serverURL)!) else {
            return
        }
        
        URLSession.shared.dataTask(with: request) { (data, response, error) in
            guard let response = response as? HTTPURLResponse else {
                return
            }
                        
            completion(response, data)
        }.resume()
    }
    
    func updateBorrowing(accessToken: String, borrowing: Borrowing, completion: @escaping (HTTPURLResponse, Data?) -> Void) {
        guard let request = PatchBorrowingRequest(accessToken: accessToken, borrowing: borrowing).request(for: URL(string: ServerManager.shared.serverURL)!) else {
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
