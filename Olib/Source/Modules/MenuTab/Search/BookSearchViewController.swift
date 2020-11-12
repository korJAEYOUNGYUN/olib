//
//  BookSearchViewController.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/10/14.
//

import UIKit

class BookSearchViewController: UIViewController {

    @IBOutlet weak var libraryTextField: UITextField!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var authorTextField: UITextField!
    @IBOutlet weak var publisherTextField: UITextField!
    @IBOutlet weak var yearTextField: UITextField!
    @IBOutlet weak var searchButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func searchBook(_ sender: Any) {
        let searchedBooksVC = UIStoryboard(name: "SearchedBooksTableViewController", bundle: nil).instantiateViewController(withIdentifier: "SearchedBooksTableViewController") as! SearchedBooksTableViewController
        
        // searchedBooksVc로 검색 조건들 전송
        searchedBooksVC.queries = getQueries()
        
        if let n = self.navigationController {
            n.pushViewController(searchedBooksVC, animated: true)
        }
    }
    
    private func getQueries() -> [String: String]? {
        var queries = [String: String]()
        
        if let library = libraryTextField.text {
            queries["library"] = library
        }
        if let title = titleTextField.text {
            queries["title"] = title
        }
        if let author = authorTextField.text {
            queries["author"] = author
        }
        if let publisher = publisherTextField.text {
            queries["publisher"] = publisher
        }
        if let year = yearTextField.text {
            queries["year"] = year
        }
        
        if queries.isEmpty {
            return nil
        } else {
            return queries
        }
    }
}
