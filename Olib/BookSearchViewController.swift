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
    @IBOutlet weak var isbnTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func searchBook(_ sender: Any) {
        let searchedBooksVC = UIStoryboard(name: "SearchedBooksTableViewController", bundle: nil).instantiateViewController(withIdentifier: "SearchedBooksTableViewController")
        
        if let n = self.navigationController {
            n.pushViewController(searchedBooksVC, animated: true)
        } else {
            print("no navigation")
        }
    }
}
