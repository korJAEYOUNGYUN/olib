//
//  MyBookListViewController.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/10/15.
//

import UIKit

class MyBookListViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let CURRENT_SECTION = 0
    let PREVIOUS_SECTION = 1
    
    var currentBorrowingList = [Borrowing]()
    var previousBorrowingList = [Borrowing]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension

        tableView.register(UINib(nibName: "CurrentBorrowingTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrentBorrowingTableViewCell")
        tableView.register(UINib(nibName: "PreviousBorrowingTableViewCell", bundle: nil), forCellReuseIdentifier: "PreviousBorrowingTableViewCell")
        
        DispatchQueue.global(qos: .userInitiated).async {
            self.getBorrowingList()
        }
    }
    
    private func getBorrowingList() {
        let authManager = AuthManager.shared
        guard let accessToken = authManager.accessToken else {
            return
        }
        
        let borrowingClient = BorrowingClient()
        
        let currentBorrowingQueries = ["user": String(authManager.userId!), "is_returned": "false"]
        borrowingClient.getBorrowingList(accessToken: accessToken, queries: currentBorrowingQueries, completion: handleGetCurrentBorrowingList)
        
        let previousBorrowingQueries = ["user": String(authManager.userId!), "is_returned": "true"]
        borrowingClient.getBorrowingList(accessToken: accessToken, queries: previousBorrowingQueries, completion: handleGetPreviousBorrowingList)
    }
    
    private func handleGetCurrentBorrowingList(response: HTTPURLResponse, data: Data?) {
        switch response.statusCode {
        case 200:
            if let data = data {
                currentBorrowingList = Borrowing.parse(data: data)
                
                DispatchQueue.main.async {
                    self.tableView.reloadSections(IndexSet(integer: self.CURRENT_SECTION), with: .automatic)
                }
            }
        // no permission
        case 401:
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Permissioin error", message: "Need to sign in.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        // server error
        default:
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Network error", message: "Please try it later.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    private func handleGetPreviousBorrowingList(response: HTTPURLResponse, data: Data?) {
        switch response.statusCode {
        case 200:
            if let data = data {
                previousBorrowingList = Borrowing.parse(data: data)
                
                DispatchQueue.main.async {
                    self.tableView.reloadSections(IndexSet(integer: self.PREVIOUS_SECTION), with: .automatic)
                }
            }
        // no permission
        case 401:
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Permissioin error", message: "Need to sign in.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        // server error
        default:
            DispatchQueue.main.async {
                let alert = UIAlertController(title: "Network error", message: "Please try it later.", preferredStyle: .alert)
                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
}
