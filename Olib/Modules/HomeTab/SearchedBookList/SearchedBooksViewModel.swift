//
//  SearchedBooksViewModel.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/12/11.
//

import Foundation
import RxSwift

class SearchedBooksViewModel: BaseViewModel {
    
    var queries: BehaviorSubject<[String: String]?>
    var searchedBooks = PublishSubject<[Book]>()
    
    init(coordinator: MainCoordinator, queries: [String: String]?) {
        self.queries = BehaviorSubject(value: queries)

        super.init(coordinator: coordinator)

        self.queries
            .subscribe(onNext: { [weak self] queries in
                guard let accessToken = AuthManager.shared.accessToken else {
                    return
                }
                
                if let self = self {
                    BookClient().rxSearchBooks(accessToken: accessToken, queries: queries)
                        .map { Book.parse(data: $0) }
                        .subscribe(self.searchedBooks)
                        .disposed(by: self.disposeBag)
                }
            })
            .disposed(by: disposeBag)
        
    }
}
