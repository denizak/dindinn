//
//  CartItemButtonViewModel.swift
//  dindinn
//
//  Created by Deni Zakya on 11/05/21.
//

import Foundation
import RxSwift
import RxCocoa

struct CartItemButtonViewModel {
    
    private let getNumberOfItems: () -> Observable<Int>
    
    var numberOfItems: Driver<Int> {
        getNumberOfItems().asDriver(onErrorJustReturn: 0)
    }
    
    init(numberOfItems: @escaping () -> Observable<Int>) {
        self.getNumberOfItems = numberOfItems
    }
}
