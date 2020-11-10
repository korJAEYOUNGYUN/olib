//
//  SearchedBooksTableViewController.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/10/14.
//

import UIKit

class SearchedBooksTableViewController: UITableViewController {

    var searchedBookList = [Book]()
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
        
        BookClient().searchBooks(accessToken: accessToken, queries: queries, completion: handleSearchedBook)
    }
        
    private func handleSearchedBook(_ response: HTTPURLResponse, _ data: Data?) {
        switch response.statusCode {
        case 200:
            if let data = data {
                searchedBookList = try! JSONDecoder().decode([Book].self, from: data)
                
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
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

        cell.titleLabel.text = book.book_info.title
        cell.libraryLabel.text = book.library.name
        cell.authorLabel.text = book.book_info.author
        cell.publisherLabel.text = book.book_info.publisher

        return cell
    }
    
}
