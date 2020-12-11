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

//        getSearchedBooks()
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
    
//    private func getSearchedBooks() {
//        guard let accessToken = AuthManager.shared.accessToken else {
//            print("getSearchBooks: No access token returned from authmanager to searchedbookstableviewcontroller.")
//            return
//        }
//
//        BookClient().searchBooks(accessToken: accessToken, queries: queries, completion: handleSearchedBook)
//    }
//
//    private func handleSearchedBook(_ response: HTTPURLResponse, _ data: Data?) {
//        switch response.statusCode {
//        case 200:
//            if let data = data {
//                searchedBookList = Book.parse(data: data)
//
//                DispatchQueue.main.async {
//                    self.tableView.reloadData()
//                }
//            }
//        // no permission
//        case 401:
//            DispatchQueue.main.async {
//                let alert = UIAlertController(title: "Permission error", message: "Need to sign in.", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }
//        // server error
//        default:
//            DispatchQueue.main.async {
//                let alert = UIAlertController(title: "Network error", message: "Please try it later.", preferredStyle: .alert)
//                alert.addAction(UIAlertAction(title: "OK", style: .cancel, handler: nil))
//                self.present(alert, animated: true, completion: nil)
//            }
//        }
//    }
//    // MARK: - Table view data source
//
//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }
//
//    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        return searchedBookList.count
//    }
//
//    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
//        return UITableView.automaticDimension
//    }
//
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchedBookTableViewCell", for: indexPath) as! SearchedBookTableViewCell
//
//        // Configure the cell...
//        let book = searchedBookList[indexPath.row]
//
//        cell.titleLabel.text = book.book_info.title
//        cell.libraryLabel.text = book.library.name
//        cell.authorLabel.text = book.book_info.author
//        cell.publisherLabel.text = book.book_info.publisher
//
//        return cell
//    }
    
}
