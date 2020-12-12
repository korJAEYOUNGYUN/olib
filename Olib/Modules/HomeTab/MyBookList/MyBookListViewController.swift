//
//  MyBookListViewController.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/10/15.
//

import UIKit
import RxSwift
import RxCocoa

class MyBookListViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: MyBookListViewModel!
    
    @IBOutlet weak var tableView: UITableView!
    
    let CURRENT_SECTION = 0
    let PREVIOUS_SECTION = 1
    
    var currentBorrowingList = [Borrowing]()
    var previousBorrowingList = [Borrowing]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.estimatedRowHeight = 50
        tableView.rowHeight = UITableView.automaticDimension

        tableView.register(UINib(nibName: "CurrentBorrowingTableViewCell", bundle: nil), forCellReuseIdentifier: "CurrentBorrowingTableViewCell")
        tableView.register(UINib(nibName: "PreviousBorrowingTableViewCell", bundle: nil), forCellReuseIdentifier: "PreviousBorrowingTableViewCell")
        
        bindUI()
    }
    
    func bindUI() {
        
        Observable.combineLatest(viewModel.currentBorrowingList, viewModel.previousBorrowingList) { [$0, $1] }
            .bind(to: tableView.rx.items(dataSource: viewModel.dataSource))
            .disposed(by: rx.disposeBag)
        
        viewModel.getBorrowingList()
    }
}
