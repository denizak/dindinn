//
//  MainMenuViewModelTest.swift
//  dindinnTests
//
//  Created by Deni Zakya on 10/05/21.
//

import XCTest
import RxSwift

@testable import dindinn

final class MainMenuViewModelTest: XCTestCase {

    func testViewLoad() {
        let expectedCategory = [Category(id: 1, name: "category1",
                                        menu: [MenuItem(id: 1,
                                                        name: "menu1",
                                                        description: "description1",
                                                        price: 10, unit: "100 grams")])]
        let expectedHeadline = [HeadlineItem(id: 1, image: "image")]
        let mainMenuViewModel = MainMenuViewModel(showMainMenu: {
            .just(MainMenu(headlines: [HeadlineItem(id: 1, image: "image")],
                           categories: [Category(id: 1, name: "category1",
                                                 menu: [MenuItem(id: 1,
                                                                 name: "menu1",
                                                                 description: "description1",
                                                                 price: 10, unit: "100 grams")])]))
        }, addMenuItem: { _ in})
        
        let categoriesDisposable = mainMenuViewModel.categories
            .drive(onNext: { categories in
                XCTAssertEqual(categories, expectedCategory)
            })
        let headlineDisposable = mainMenuViewModel.headlines.drive(onNext: { headlines in
            XCTAssertEqual(headlines, expectedHeadline)
        })
        defer {
            categoriesDisposable.dispose()
            headlineDisposable.dispose()
        }
        
        mainMenuViewModel.viewLoad()
    }
    
    func testAddItem() {
        var actualItems: [MenuItem] = []
        let viewModel = MainMenuViewModel(showMainMenu: { .empty() },
                                          addMenuItem: { item in actualItems.append(item) })
        
        viewModel.addItem(item: MenuItem(id: 1, name: "name",
                                         description: "", price: 1, unit: ""))
        
        XCTAssertEqual(actualItems.first!.id, 1)
    }

}
