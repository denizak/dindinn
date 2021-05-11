//
//  CartViewModel.swift
//  dindinn
//
//  Created by Deni Zakya on 11/05/21.
//

import Foundation
import RxSwift
import RxCocoa

struct CartViewModel {
    
    var items: [MenuItem] {
        manageCartItem.items
    }
    
    private let manageCartItem: ManageCartItem
    
    init(manageCartItem: ManageCartItem) {
        self.manageCartItem = manageCartItem
    }
}
