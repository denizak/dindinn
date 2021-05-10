//
//  CartItemStoreTest.swift
//  dindinnTests
//
//  Created by Deni Zakya on 10/05/21.
//

import XCTest

@testable import dindinn

final class CartItemStoreTest: XCTestCase {

    func testAdd() {
        let store = CartItemStore.shared
        
        store.add(item: MenuItem(id: 1,
                                 name: "name1",
                                 description: "description1",
                                 price: 10, unit: "100 grams"))
        
        XCTAssertEqual(MenuItem(id: 1,
                                name: "name1",
                                description: "description1", price: 10,
                                unit: "100 grams"),
                       store.items.first!)
    }
    
    func testRemove() {
        let store = CartItemStore.shared
        
        store.add(item: MenuItem(id: 1,
                                 name: "name1",
                                 description: "description1",
                                 price: 10, unit: "100 grams"))
        
        store.remove(id: 1)
        
        XCTAssertEqual(store.items.count, 0)
    }

}
