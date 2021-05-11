//
//  ShowMainMenu.swift
//  dindinn
//
//  Created by Deni Zakya on 10/05/21.
//

import Foundation
import RxSwift

struct HeadlineItem : Equatable {
    let id: Int
    let image: String
}

struct Category : Equatable {
    let id: Int
    let name: String
    let menu: [MenuItem]
}

struct MenuItem : Equatable {
    let id: Int
    let name: String
    let description: String
    let price: Int
    let unit: String
    let image: String
}

struct MainMenu : Equatable {
    let headlines: [HeadlineItem]
    let categories: [Category]
}

struct ShowMainMenu {
    let getHeadline: () -> Observable<[HeadlineItem]>
    let getMenu: () -> Observable<[Category]>
    
    func show() -> Observable<MainMenu> {
        Observable.zip(getHeadline(), getMenu())
            .map { headlineItems, categoryItems in
                MainMenu(headlines: headlineItems, categories: categoryItems)
            }
    }
}
