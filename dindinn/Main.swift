//
//  Main.swift
//  dindinn
//
//  Created by Deni Zakya on 11/05/21.
//

import Foundation
import RxSwift

func createCartItemButtonViewModel() -> CartItemButtonViewModel {
    CartItemButtonViewModel(numberOfItems: {
        manageCartItem.numberOfItems
    })
}

func createMainMenuViewModel() -> MainMenuViewModel {
    
    MainMenuViewModel(showMainMenu: {
        createShowMainMenu().show()
    }, addMenuItem: {
        manageCartItem.add(item: $0)
    })
}

let manageCartItem: ManageCartItem = ManageCartItemImpl(store: sharedCartItemStore())

func createShowMainMenu() -> ShowMainMenu {
    ShowMainMenu(getHeadline: {
        createHeadlineService().get()
            .map { headlineResponses in
                headlineResponses.map {
                    HeadlineItem(id: $0.id, image: $0.image)
                }
            }
    }, getMenu: {
        createMenuService().get()
            .map { categoryResponses in
                categoryResponses.map {
                    Category(id: $0.id, name: $0.name,
                             menu: $0.menu.map({
                                MenuItem(id: $0.id,
                                         name: $0.name,
                                         description: $0.description,
                                         price: $0.price,
                                         unit: $0.unit,
                                         image: $0.image)
                             }))
                }
            }
    })
}

func createHeadlineService() -> HeadlineService {
    HeadlineService(api: {
        .just(
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
        )
    })
}

func createMenuService() -> MenuService {
    MenuService(api: {
        .just(
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
                           "unit":"10 grams, 2 pieces",
                           "image": "https://loremflickr.com/g/320/320/food/all"
                        },
                        {
                           "id":2,
                           "name":"name 2",
                           "description":"description 2",
                           "price":90,
                           "unit":"100 grams, 10 pieces",
                           "image": "https://loremflickr.com/g/320/320/food/all"
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
                           "unit":"20 grams, 4 pieces",
                           "image": "https://loremflickr.com/g/320/320/food/all"
                        },
                        {
                           "id":12,
                           "name":"name 12",
                           "description":"description 12",
                           "price":190,
                           "unit":"200 grams, 20 pieces",
                           "image": "https://loremflickr.com/g/320/320/food/all"
                        }
                     ]
                  }
               ]
            }
            """.data(using: .utf8)!
        )
    })
}
