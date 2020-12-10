//
//  BookSearchViewModel.swift
//  Olib
//
//  Created by jaeyoung Yun on 2020/12/06.
//

import Foundation
import RxSwift

class BookSearchViewModel: BaseViewModel {
            
    func searchBook(with queries: [String: String]?) {
        coordinator?.searchedBookList(queries)
    }
}
