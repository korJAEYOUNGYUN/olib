//
//  MyBookListViewModel.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/12/06.
//

import Foundation
import RxSwift
import RxDataSources

struct SectionOfBorrowing: SectionModelType {
    
    var header: String
    var items: [Borrowing]
    
    init(original: SectionOfBorrowing, items: [Borrowing]) {
        self = original
        self.items = items
    }

    init (items: [Borrowing], header: String) {
        self.items = items
        self.header = header
    }
}

class MyBookListViewModel: BaseViewModel {
    
    let currentBorrowingList = PublishSubject<SectionOfBorrowing>()
    let previousBorrowingList = PublishSubject<SectionOfBorrowing>()
    
    let dataSource: RxTableViewSectionedReloadDataSource<SectionOfBorrowing> = {
        let ds = RxTableViewSectionedReloadDataSource<SectionOfBorrowing> { (dataSource, tableView, indexPath, borrowing) -> UITableViewCell in
            if borrowing.is_returned ?? false {
                let cell = tableView.dequeueReusableCell(withIdentifier: "PreviousBorrowingTableViewCell", for: indexPath) as! PreviousBorrowingTableViewCell
                
                cell.titleLabel.text = borrowing.book.book_info.title
                cell.authorLabel.text = borrowing.book.book_info.author
                cell.borrowDateLabel.text = borrowing.borrowed_at
                cell.returnDateLabel.text = borrowing.returned_at
                
                return cell
            } else {
                let cell = tableView.dequeueReusableCell(withIdentifier: "CurrentBorrowingTableViewCell", for: indexPath) as! CurrentBorrowingTableViewCell
                
                cell.titleLabel.text = borrowing.book.book_info.title
                cell.authorLabel.text = borrowing.book.book_info.author
                cell.borrowDateLabel.text = borrowing.borrowed_at
                cell.deadlineLabel.text = borrowing.due
                
                return cell
            }
        }
        
        ds.titleForHeaderInSection = { dataSource, index in
            dataSource.sectionModels[index].header
        }
        
        return ds
    }()
    
    func getBorrowingList() {
        let authManager = AuthManager.shared
        guard let accessToken = authManager.accessToken else {
            return
        }
        
        let borrowingClient = BorrowingClient()
        
        let currentBorrowingQueries = ["user": String(authManager.userId!), "is_returned": "false"]
        borrowingClient.rxGetBorrowingList(accessToken: accessToken, queries: currentBorrowingQueries)
            .map { Borrowing.parse(data: $0) }
            .subscribe(onNext: { [weak self] (borrowings) in
                self?.currentBorrowingList.onNext(SectionOfBorrowing(items: borrowings, header: "Current Borrowings"))
            }, onError: { (error) in
                print(error)
            }, onDisposed: {
                print("disposed")
            })
            .disposed(by: disposeBag)
        
        let previousBorrowingQueries = ["user": String(authManager.userId!), "is_returned": "true"]
        borrowingClient.rxGetBorrowingList(accessToken: accessToken, queries: previousBorrowingQueries)
            .map { Borrowing.parse(data: $0) }
            .subscribe { [weak self] (borrowings) in
                self?.previousBorrowingList.onNext(SectionOfBorrowing(items: borrowings, header: "Previous Borrowings"))
            } onError: { (error) in
                print(error)
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)

    }

}
