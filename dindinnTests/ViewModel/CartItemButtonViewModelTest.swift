//
//  CartItemButtonViewModelTest.swift
//  dindinnTests
//
//  Created by Deni Zakya on 11/05/21.
//

import XCTest
import RxSwift
import RxCocoa

@testable import dindinn

final class CartItemButtonViewModelTest: XCTestCase {

    func testNumberOfItems() {
        let numberOfItemsRelay = PublishRelay<Int>()
        let viewModel = CartItemButtonViewModel(numberOfItems: { numberOfItemsRelay.asObservable() })
        
        var actualNumber = 0
        let disposable = viewModel.numberOfItems
            .drive(onNext: { actualNumber = $0 })
        defer { disposable.dispose() }
        
        numberOfItemsRelay.accept(20)
        
        XCTAssertEqual(actualNumber, 20)
        
    }

}
