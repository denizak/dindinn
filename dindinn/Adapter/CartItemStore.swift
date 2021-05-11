//
//  CartItemStore.swift
//  dindinn
//
//  Created by Deni Zakya on 10/05/21.
//

import Foundation

protocol CartItemStore {
    func add(item: MenuItem)
    func remove(id: Int)
    var items: [MenuItem] { get }
}

func sharedCartItemStore() -> CartItemStore {
    CartItemStoreImpl.shared
}

final class CartItemStoreImpl: CartItemStore {
    
    static let shared = CartItemStoreImpl()
    
    private(set) var items: [MenuItem] = []
    
    func add(item: MenuItem) {
        items.append(item)
    }
    
    func remove(id: Int) {
        items.removeAll { $0.id == id }
    }
}
