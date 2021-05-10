//
//  ShowMainMenuTest.swift
//  dindinnTests
//
//  Created by Deni Zakya on 10/05/21.
//

import XCTest
import RxSwift
import RxBlocking

@testable import dindinn

final class ShowMainMenuTest: XCTestCase {

    func testShow() throws {
        let showMainMenu = ShowMainMenu(getHeadline: {
                                            .just([
                                                HeadlineItem(id: 1, image: "image_url")
                                            ]) },
        getMenu: { .just([
            Category(id: 1, name: "category1",
                     menu: [MenuItem(id: 1,
                                     name: "menu1",
                                     description: "description1",
                                     price: 10, unit: "100 grams")])
        ]) })
        
        let expectedResult = MainMenu(headlines: [HeadlineItem(id: 1, image: "image_url")],
                                      categories: [Category(id: 1,
                                                            name: "category1",
                                                            menu: [MenuItem(id: 1,
                                                                            name: "menu1",
                                                                            description: "description1",
                                                                            price: 10,
                                                                            unit: "100 grams")
                                                            ])])
        
        let actualResult = try showMainMenu.show().toBlocking().first()
        
        XCTAssertEqual(expectedResult, actualResult)
    }

}
