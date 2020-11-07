//
//  MyBookListViewController+UITableViewControl.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/10/15.
//

import UIKit

extension MyBookListViewController: UITableViewDelegate, UITableViewDataSource {
    
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
            
            let book = currentBorrowingList[indexPath.row]
            cell.titleLabel.text = ""
            cell.authorLabel.text = ""
            cell.borrowDateLabel.text = ""
            cell.deadlineLabel.text = ""
            
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "PreviousBorrowingTableViewCell", for: indexPath) as! PreviousBorrowingTableViewCell
            
            let book = previousBorrowingList[indexPath.row]
            cell.titleLabel.text = ""
            cell.authorLabel.text = ""
            cell.borrowDateLabel.text = ""
            cell.returnDateLabel.text = ""
            
            return cell
        }
    }
}
