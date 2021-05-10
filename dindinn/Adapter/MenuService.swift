//
//  MenuService.swift
//  dindinn
//
//  Created by Deni Zakya on 10/05/21.
//

import Foundation
import RxSwift

struct CategoriesResponse: Decodable, Equatable {
    let categories: [CategoryResponse]
}

struct CategoryResponse: Decodable, Equatable {
    let id: Int
    let name: String
    let menu: [MenuItemResponse]
}

struct MenuItemResponse: Decodable, Equatable {
    let id: Int
    let name: String
    let description: String
    let price: Int
    let unit: String
}

struct MenuService {
    let api: () -> Observable<Data>
    
    func get() -> Observable<[CategoryResponse]> {
        api().map { data in
            let decoder = JSONDecoder()
            let categories = try decoder.decode(CategoriesResponse.self, from: data)
            return categories.categories
        }
    }
}
