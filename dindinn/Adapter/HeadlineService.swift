//
//  HeadlineService.swift
//  dindinn
//
//  Created by Deni Zakya on 09/05/21.
//

import Foundation
import RxSwift

struct Headline: Decodable {
    let headlines: [HeadlineItem]
}

struct HeadlineItem: Decodable, Equatable {
    let id: Int
    let image: String
}

struct HeadlineService {
    
    let api: () -> Observable<Data>
    
    func get() -> Observable<[HeadlineItem]> {
        api().map { data in
            let decoder = JSONDecoder()
            let headline = try decoder.decode(Headline.self, from: data)
            return headline.headlines
        }
    }
}
