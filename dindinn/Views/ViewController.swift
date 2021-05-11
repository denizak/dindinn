//
//  ViewController.swift
//  dindinn
//
//  Created by Deni Zakya on 09/05/21.
//

import UIKit
import RxSwift
import RxCocoa

final class ViewController: UIViewController {

    private let disposeBag = DisposeBag()
    let viewModel: MainMenuViewModel = createMainMenuViewModel()
    var categories: [Category] = []
    var headlines: [HeadlineItem] = []
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.categories
            .drive(onNext: { [unowned self] categories in
                self.categories = categories
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        viewModel.headlines
            .drive(onNext: { [unowned self] headlines in
                self.headlines = headlines
                self.tableView.reloadData()
            }).disposed(by: disposeBag)
        
        self.tableView.register(UINib(nibName: "HeadlineTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "HeadlineTableViewCell")
        self.tableView.register(UINib(nibName: "MenuItemTableViewCell", bundle: nil),
                                forCellReuseIdentifier: "MenuItemTableViewCell")
        
        viewModel.viewLoad()
    }

}

extension ViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cell = tableView.dequeueReusableCell(withIdentifier: HeadlineTableViewCell.identifier) as! HeadlineTableViewCell
            cell.setup(headlines: headlines)
            return cell
            
        case 1: let cell = tableView.dequeueReusableCell(withIdentifier: MenuItemTableViewCell.identifier) as! MenuItemTableViewCell
            cell.setup(categories.first!.menu[indexPath.row])
            return cell
        default: return UITableViewCell()
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0: return tableView.frame.width
        case 1: return 500
        default: return 0
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int { 2 }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        switch section {
        case 0: return UIView(frame: .init(x: 0, y: 0, width: tableView.frame.width, height: 0))
        case 1:
            return UIView(frame: .init(x: 0, y: 0, width: tableView.frame.width, height: 0))
        default: return nil
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0: return 1
        case 1: return categories.first?.menu.count ?? 0
        default: return 0
        }
    }
}

extension UIImageView {
    func load(_ urlString: String) {
        guard let url = URL(string: urlString) else { return }
        DispatchQueue.global(qos: .background).async {
            if let data = try? Data(contentsOf: url) {
                DispatchQueue.main.async {
                    self.image = UIImage(data: data)
                }
            }
        }
    }
}

