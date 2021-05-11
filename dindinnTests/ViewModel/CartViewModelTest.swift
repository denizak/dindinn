//
//  CartViewModelTest.swift
//  dindinnTests
//
//  Created by Deni Zakya on 11/05/21.
//

import XCTest
import RxSwift
import RxCocoa

@testable import dindinn

final class CartViewModelTest: XCTestCase {

    func testViewLoad() {
        let viewModel = CartViewModel(manageCartItem: ManageCartItemStub())
        
        XCTAssertEqual(viewModel.items.count, 1)
    }

}

struct ManageCartItemStub: ManageCartItem {
    var items: [MenuItem] { [MenuItem(id: 1, name: "",
                                      description: "",
                                      price: 1, unit: "")] }
    var numberOfItems: Observable<Int> { .empty() }
    func add(item: MenuItem) {}
}
