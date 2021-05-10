//
//  MenuServiceTest.swift
//  dindinnTests
//
//  Created by Deni Zakya on 10/05/21.
//

import XCTest
import RxSwift
import RxBlocking

@testable import dindinn

final class MenuServiceTest: XCTestCase {
    
    let responseData =
        """
        {
           "categories":[
              {
                 "id":1,
                 "name":"Pizza",
                 "menu":[
                    {
                       "id":1,
                       "name":"name 1",
                       "description":"description 1",
                       "price":20,
                       "unit":"10 grams, 2 pieces"
                    },
                    {
                       "id":2,
                       "name":"name 2",
                       "description":"description 2",
                       "price":90,
                       "unit":"100 grams, 10 pieces"
                    }
                 ]
              },
              {
                 "id":2,
                 "name":"Sushi",
                 "menu":[
                    {
                       "id":11,
                       "name":"name 11",
                       "description":"description 11",
                       "price":120,
                       "unit":"20 grams, 4 pieces"
                    },
                    {
                       "id":12,
                       "name":"name 12",
                       "description":"description 12",
                       "price":190,
                       "unit":"200 grams, 20 pieces"
                    }
                 ]
              }
           ]
        }
        """.data(using: .utf8)!

    func testGet() throws {
        let apiStub: () -> Observable<Data> = { [unowned self] () -> Observable<Data> in
            .just(self.responseData)
        }
        let expectedResponse = [
            Category(
                id: 1,
                name: "Pizza",
                menu: [
                    MenuItem(id: 1, name: "name 1", description: "description 1",
                             price: 20, unit: "10 grams, 2 pieces"),
                    MenuItem(id: 2, name: "name 2", description: "description 2",
                             price: 90, unit: "100 grams, 10 pieces")
                ]
            ),
            Category(
                id: 2,
                name: "Sushi",
                menu: [
                    MenuItem(id: 11, name: "name 11", description: "description 11",
                             price: 120, unit: "20 grams, 4 pieces"),
                    MenuItem(id: 12, name: "name 12", description: "description 12",
                             price: 190, unit: "200 grams, 20 pieces")
                ]
            )
        ]
        
        let service = MenuService(api: apiStub)
        
        let actualResponse = try! service.get().toBlocking().first()
        
        XCTAssertEqual(expectedResponse, actualResponse)
    }

}
