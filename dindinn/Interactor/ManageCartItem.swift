//
//  ManageCartItem.swift
//  dindinn
//
//  Created by Deni Zakya on 11/05/21.
//

import Foundation
import RxRelay
import RxSwift

protocol ManageCartItem {
    var items: [MenuItem] { get }
    var numberOfItems: Observable<Int> { get }
    func add(item: MenuItem)
}

struct ManageCartItemImpl : ManageCartItem {
    private let store: CartItemStore
    
    var items: [MenuItem] { store.items }
    var numberOfItems: Observable<Int> {
        numberOfItemsRelay.asObservable()
    }
    
    private let numberOfItemsRelay = BehaviorRelay<Int>(value: 0)
    
    init(store: CartItemStore) {
        self.store = store
    }
    
    func add(item: MenuItem) {
        store.add(item: item)
        
        numberOfItemsRelay.accept(store.items.count)
    }
}
