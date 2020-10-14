//
//  SearchedBooksTableViewController.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/10/14.
//

import UIKit

// temporary mock book
struct Book {
    var title: String
    var publisher: String
    var author: String
}

class SearchedBooksTableViewController: UITableViewController {

    var searchedBookList = [Book]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.tableView.register(UINib(nibName: "SearchedBookTableViewCell", bundle: nil), forCellReuseIdentifier: "SearchedBookTableViewCell")
        self.tableView.estimatedRowHeight = 50
        
        // temp data
        searchedBookList.append(Book(title: "aaaaaaa", publisher: "aa", author: "aaa"))
        searchedBookList.append(Book(title: "b", publisher: "b", author: "b"))
        searchedBookList.append(Book(title: "aaaaaaa", publisher: "aa", author: "aaa"))

        searchedBookList.append(Book(title: "1cccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccccc", publisher: "2ccccccccccccccccccccccccccccccc", author: "3ccccccccccccccccccccccccccccccccccc"))

        searchedBookList.append(Book(title: "aaaaaaa", publisher: "aa", author: "aaa"))

        searchedBookList.append(Book(title: "aaaaaaa", publisher: "aa", author: "aaa"))

        searchedBookList.append(Book(title: "aaaaaaa", publisher: "aa", author: "aaa"))

        searchedBookList.append(Book(title: "aaaaaaa", publisher: "aa", author: "aaa"))
        searchedBookList.append(Book(title: "aaaaaaa", publisher: "aa", author: "aaa"))


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
        cell.titleLabel.text = book.title
        cell.authorLabel.text = book.author
        cell.publisherLabel.text = book.publisher

        return cell
    }
    
}