//
//  HeadlineServiceTest.swift
//  dindinnTests
//
//  Created by Deni Zakya on 09/05/21.
//

import XCTest
import RxSwift
import RxBlocking

@testable import dindinn

final class HeadlineServiceTest: XCTestCase {

    let responseData =
    """
    {
     "headlines": [
      {
       "image": "https://loremflickr.com/g/320/320/food/all",
       "id": 1
      },
      {
       "image": "https://loremflickr.com/g/320/320/food/all",
       "id": 2
      }
     ]
    }
    """.data(using: .utf8)!
    
    func testGet() throws {
        let apiStub: () -> Observable<Data> = { [unowned self] () -> Observable<Data> in
            .just(self.responseData)
        }
        let expectedResponse = [
            HeadlineItem(id: 1,
                image: "https://loremflickr.com/g/320/320/food/all"),
            HeadlineItem(id: 2,
                image: "https://loremflickr.com/g/320/320/food/all")]
            
        let service = HeadlineService(api: apiStub)
        
        let actualResponse = try! service.get().toBlocking().first()
        
        XCTAssertEqual(expectedResponse, actualResponse)
    }

}
