//
//  HeadlineService.swift
//  dindinn
//
//  Created by Deni Zakya on 09/05/21.
//

import Foundation
import RxSwift

struct HeadlineResponse: Decodable {
    let headlines: [HeadlineItemResponse]
}

struct HeadlineItemResponse: Decodable, Equatable {
    let id: Int
    let image: String
}

struct HeadlineService {
    
    let api: () -> Observable<Data>
    
    func get() -> Observable<[HeadlineItemResponse]> {
        api().map { data in
            let decoder = JSONDecoder()
            let headline = try decoder.decode(HeadlineResponse.self, from: data)
            return headline.headlines
        }
    }
}
