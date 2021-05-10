//
//  CartItemStore.swift
//  dindinn
//
//  Created by Deni Zakya on 10/05/21.
//

import Foundation

final class CartItemStore {
    
    static let shared = CartItemStore()
    
    private(set) var items: [MenuItem] = []
    
    func add(item: MenuItem) {
        items.append(item)
    }
    
    func remove(id: Int) {
        items.removeAll { $0.id == id }
    }
}
