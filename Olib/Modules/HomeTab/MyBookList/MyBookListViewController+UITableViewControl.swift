//
//  MyBookListViewController+UITableViewControl.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/10/15.
//

import UIKit

extension MyBookListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case CURRENT_SECTION:
            return currentBorrowingList.count
        case PREVIOUS_SECTION:
            return previousBorrowingList.count
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == CURRENT_SECTION {
            let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentBorrowingTableViewCell", for: indexPath) as! CurrentBorrowingTableViewCell
            
            let borrowing = currentBorrowingList[indexPath.row]
    
            cell.titleLabel.text = borrowing.book.book_info.title
            cell.authorLabel.text = borrowing.book.book_info.author
            cell.borrowDateLabel.text = borrowing.borrowed_at
            cell.deadlineLabel.text = borrowing.due
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PreviousBorrowingTableViewCell", for: indexPath) as! PreviousBorrowingTableViewCell
            
            let borrowing = previousBorrowingList[indexPath.row]
            
            cell.titleLabel.text = borrowing.book.book_info.title
            cell.authorLabel.text = borrowing.book.book_info.author
            cell.borrowDateLabel.text = borrowing.borrowed_at
            cell.returnDateLabel.text = borrowing.returned_at
            
            return cell
        }
    }
}
