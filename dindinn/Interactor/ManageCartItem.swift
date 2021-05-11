//
//  ManageCartItem.swift
//  dindinn
//
//  Created by Deni Zakya on 11/05/21.
//

import Foundation
import RxRelay
import RxSwift

struct ManageCartItem {
    private let store: CartItemStore
    
    var items: [MenuItem] { store.items }
    var numberOfItems: Observable<Int> {
        numberOfItemsRelay.asObservable()
    }
    
    private let numberOfItemsRelay = PublishRelay<Int>()
    
    init(store: CartItemStore) {
        self.store = store
    }
    
    func add(item: MenuItem) {
        store.add(item: item)
        
        numberOfItemsRelay.accept(store.items.count)
    }
}
