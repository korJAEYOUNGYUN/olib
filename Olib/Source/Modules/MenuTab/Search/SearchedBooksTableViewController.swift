//
//  SearchedBooksTableViewController.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/10/14.
//

import UIKit

class SearchedBooksTableViewController: UITableViewController {

    var searchedBookList = [Book]()
    var bookInfoDict = [Int: BookInfo]()
    var queries: [String: String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "SearchedBookTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchedBookTableViewCell")
        self.tableView.estimatedRowHeight = 50

        getSearchedBooks()
    }
    
    private func getSearchedBooks() {
        guard let accessToken = AuthManager.shared.accessToken else {
            return
        }
        
        BooksClient().searchBooks(accessToken: accessToken, queries: queries, completion: handleSearchedBook)
    }
    
    // Todo: BookInfo가 다 채워지면 테이블뷰 로딩해야함
    private func getBookInfos() {
        guard let accessToken = AuthManager.shared.accessToken else {
            return
        }
        
        let booksClient = BooksClient()
        for book in searchedBookList {
            booksClient.bookInfo(accessToken: accessToken, bookId: book.book_info, completion: handleGetBookInfo)
        }
    }
    
    private func handleGetBookInfo(_ response: HTTPURLResponse, _ data: Data?) {
        switch response.statusCode {
        case 200:
            if let data = data {
                let bookInfo = try! JSONDecoder().decode(BookInfo.self, from: data)
                bookInfoDict[bookInfo.id] = bookInfo
            }
        // no permission
        case 401:
            return
        // server error
        default:
            return
        }

    }
    
    private func handleSearchedBook(_ response: HTTPURLResponse, _ data: Data?) {
        switch response.statusCode {
        case 200:
            if let data = data {
                searchedBookList = try! JSONDecoder().decode([Book].self, from: data)
                getBookInfos()
            }
        // no permission
        case 401:
            return
        // server error
        default:
            return
        }
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return searchedBookList.count
    }

    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "SearchedBookTableViewCell", for: indexPath) as! SearchedBookTableViewCell

        // Configure the cell...
        let book = searchedBookList[indexPath.row]
        guard let bookInfo = bookInfoDict[book.book_info] else {
            return cell
        }
        cell.titleLabel.text = bookInfo.title
        cell.authorLabel.text = bookInfo.author
        cell.publisherLabel.text = bookInfo.publisher

        return cell
    }
    
}
