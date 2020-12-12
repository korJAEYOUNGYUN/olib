//
//  SearchedBooksTableViewController.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/10/14.
//

import UIKit
import RxSwift
import RxCocoa

class SearchedBooksTableViewController: UIViewController, ViewModelBindableType {
    
    var viewModel: SearchedBooksViewModel!
    
    @IBOutlet var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.tableView.register(UINib(nibName: "SearchedBookTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchedBookTableViewCell")
        self.tableView.estimatedRowHeight = 50

        bindUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func bindUI() {
        viewModel.searchedBooks
            .bind(to: tableView.rx.items(cellIdentifier: "SearchedBookTableViewCell", cellType: SearchedBookTableViewCell.self)) { index, book, cell in
                cell.titleLabel.text = book.book_info.title
                cell.libraryLabel.text = book.library.name
                cell.authorLabel.text = book.book_info.author
                cell.publisherLabel.text = book.book_info.publisher
            }
            .disposed(by: rx.disposeBag)
    }
}
