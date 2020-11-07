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
    var libraryDict = [Int: Library]()
    var queries: [String: String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "SearchedBookTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchedBookTableViewCell")
        self.tableView.estimatedRowHeight = 50

        getSearchedBooks()
    }
    
    private func getSearchedBooks() {
        guard let accessToken = AuthManager.shared.accessToken else {
            print("getSearchBooks: No access token returned from authmanager to searchedbookstableviewcontroller.")
            return
        }
        
        BooksClient().searchBooks(accessToken: accessToken, queries: queries, completion: handleSearchedBook)
    }
    
    private func getBookInfosAndLibraries() {
        guard let accessToken = AuthManager.shared.accessToken else {
            print("getBookInfos: No access token returned from authmanager to searchedbookstableviewcontroller.")
            return
        }
        
        for (i, book) in searchedBookList.enumerated() {
            BooksClient().getBookInfo(accessToken: accessToken, bookId: book.book_info, completion: handleGetBookInfo)
            LibraryClient().getLibrary(accessToken: accessToken, libraryId: book.library, completion: handleGetLibrary)

            DispatchQueue.main.async {
                self.tableView.reloadRows(at: [IndexPath(row: i, section: 0)], with: .automatic)
            }
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
            print("handleGetBookInfo: no permission.")
            return
        // server error
        default:
            print("handleGetBookInfo: server error status code - \(response.statusCode)")
            return
        }
    }
    
    private func handleSearchedBook(_ response: HTTPURLResponse, _ data: Data?) {
        switch response.statusCode {
        case 200:
            if let data = data {
                searchedBookList = try! JSONDecoder().decode([Book].self, from: data)
                getBookInfosAndLibraries()
            }
        // no permission
        case 401:
            print("handleSearchedBook: no permission.")
            return
        // server error
        default:
            print("handleSearchedBook: server error status code - \(response.statusCode)")
            return
        }
    }
    
    private func handleGetLibrary(_ response: HTTPURLResponse, _ data: Data?) {
        switch response.statusCode {
        case 200:
            if let data = data {
                let library = try! JSONDecoder().decode(Library.self, from: data)
                libraryDict[library.id] = library
            }
        // no permission
        case 401:
            print("handleGetLibrary: no permission.")
            return
        // server error
        default:
            print("handleGetLibrary: server error status code - \(response.statusCode)")
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
        guard let library = libraryDict[book.library] else {
            return cell
        }
        cell.titleLabel.text = bookInfo.title
        cell.libraryLabel.text = library.name
        cell.authorLabel.text = bookInfo.author
        cell.publisherLabel.text = bookInfo.publisher

        return cell
    }
    
}
