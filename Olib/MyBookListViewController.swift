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
    
    var currentBorrowingList = [Book]()
    var previousBorrowingList = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UINib(nibName: "CurrentBorrowingTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrentBorrowingTableViewCell")
        tableView.register(UINib(nibName: "PreviousBorrowingTableViewCell", bundle: nil), forCellReuseIdentifier: "PreviousBorrowingTableViewCell")

    }
    
}
