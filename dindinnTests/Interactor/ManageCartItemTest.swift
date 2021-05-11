//
//  ManageCartItemTest.swift
//  dindinnTests
//
//  Created by Deni Zakya on 11/05/21.
//

import XCTest
import RxSwift

@testable import dindinn

final class ManageCartItemTest: XCTestCase {

    func testAddCartItem() {
        let cartItemStore = CartItemStoreMock()
        let manageCartItem = ManageCartItem(store: cartItemStore)
        
        manageCartItem.add(item: MenuItem(id: 1, name: "name",
                                          description: "description",
                                          price: 10, unit: "10 grams"))
        
        XCTAssertGreaterThan(cartItemStore.items.count, 0)
    }
    
    func testGetCartItem() {
        let cartItemStore = CartItemStoreMock()
        let manageCartItem = ManageCartItem(store: cartItemStore)
        
        manageCartItem.add(item: MenuItem(id: 1, name: "name",
                                          description: "description",
                                          price: 10, unit: "10 grams"))
        
        XCTAssertEqual(manageCartItem.items.first!.id, 1)
        XCTAssertEqual(manageCartItem.items.first!.name, "name")
    }
    
    func testGetCartItemNumber() {
        let cartItemStore = CartItemStoreMock()
        let manageCartItem = ManageCartItem(store: cartItemStore)
        
        var actualNumber = 0
        let disposable = manageCartItem.numberOfItems
            .subscribe(onNext: { number in actualNumber = number })
        defer { disposable.dispose() }
        
        manageCartItem.add(item: MenuItem(id: 1, name: "name",
                                          description: "description",
                                          price: 10, unit: "10 grams"))
        
        XCTAssertEqual(actualNumber, 1)
    }
}

final class CartItemStoreMock : CartItemStore {
    var items: [MenuItem] = []
    
    func add(item: MenuItem) {
        items.append(item)
    }
    
    func remove(id: Int) {
        items.removeAll { item in
            item.id == id
        }
    }
}
