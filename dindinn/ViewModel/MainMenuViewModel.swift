//
//  MainMenuViewModel.swift
//  dindinn
//
//  Created by Deni Zakya on 10/05/21.
//

import Foundation
import RxSwift
import RxCocoa

final class MainMenuViewModel {
    
    var categories : Driver<[Category]> {
        categoriesValue.asDriver(onErrorJustReturn: [])
    }
    
    var headlines : Driver<[HeadlineItem]> {
        headlinesValue.asDriver(onErrorJustReturn: [])
    }
    
    init(showMainMenu: @escaping () -> Observable<MainMenu>,
         addMenuItem: @escaping (MenuItem) -> Void) {
        self.showMainMenu = showMainMenu
        self.addMenuItem = addMenuItem
    }
    
    private let disposeBag = DisposeBag()
    private let categoriesValue = PublishRelay<[Category]>()
    private let headlinesValue = PublishRelay<[HeadlineItem]>()
    private let showMainMenu: () -> Observable<MainMenu>
    private let addMenuItem: (MenuItem) -> Void
    
    func viewLoad() {
        showMainMenu()
            .subscribe(onNext: { [weak self] mainMenu in
                self?.categoriesValue.accept(mainMenu.categories)
                self?.headlinesValue.accept(mainMenu.headlines)
            })
            .disposed(by: disposeBag)
    }
    
    func addItem(item: MenuItem) {
        self.addMenuItem(item)
    }
}
