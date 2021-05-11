//
//  MenuItemTableViewCell.swift
//  dindinn
//
//  Created by Deni Zakya on 11/05/21.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

protocol AddToCartMenuDelegate: AnyObject {
    func add(menu: MenuItem)
}

final class MenuItemTableViewCell: UITableViewCell {
    static let identifier = "MenuItemTableViewCell"
    @IBOutlet weak var menuImage: UIImageView!
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var desc: UILabel!
    @IBOutlet weak var unit: UILabel!
    @IBOutlet weak var addToCartButton: UIButton!
    
    weak var delegate: AddToCartMenuDelegate?
    
    let viewModel = createMainMenuViewModel()
    private let serialDisposable = SerialDisposable()
    
    func setup(_ menu: MenuItem) {
        menuImage.load(menu.image)
        name.text = menu.name
        desc.text = menu.description
        unit.text = menu.unit
        
        let priceString = "\(menu.price) USD"
        addToCartButton.setTitle(priceString, for: .normal)
        serialDisposable.disposable = addToCartButton.rx.tap.subscribe { [unowned self] _ in
            self.viewModel.addItem(item: menu)
            
            addToCartButton.setTitle("added", for: .normal)
            DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
                addToCartButton.setTitle(priceString, for: .normal)
            }
        }

    }
    
}
