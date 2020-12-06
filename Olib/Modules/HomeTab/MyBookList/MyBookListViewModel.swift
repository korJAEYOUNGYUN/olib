//
//  MyBookListViewModel.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/12/06.
//

import Foundation
import RxSwift

class MyBookListViewModel: BaseViewModel {
    
    let currentBorrowingList = PublishSubject<[Borrowing]>()
    let previousBorrowingList = PublishSubject<[Borrowing]>()
    
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
                self?.currentBorrowingList
                    .onNext(borrowings)
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
                self?.previousBorrowingList.onNext(borrowings)
            } onError: { (error) in
                print(error)
            } onDisposed: {
                print("disposed")
            }
            .disposed(by: disposeBag)

    }

}
