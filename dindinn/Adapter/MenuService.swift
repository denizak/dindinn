//
//  MenuService.swift
//  dindinn
//
//  Created by Deni Zakya on 10/05/21.
//

import Foundation
import RxSwift

struct Categories: Decodable, Equatable {
    let categories: [Category]
}

struct Category: Decodable, Equatable {
    let id: Int
    let name: String
    let menu: [MenuItem]
}

struct MenuItem: Decodable, Equatable {
    let id: Int
    let name: String
    let description: String
    let price: Int
    let unit: String
}

struct MenuService {
    let api: () -> Observable<Data>
    
    func get() -> Observable<[Category]> {
        api().map { data in
            let decoder = JSONDecoder()
            let categories = try decoder.decode(Categories.self, from: data)
            return categories.categories
        }
    }
}
