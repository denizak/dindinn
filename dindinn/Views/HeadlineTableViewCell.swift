//
//  HeadlineTableViewCell.swift
//  dindinn
//
//  Created by Deni Zakya on 11/05/21.
//

import Foundation
import UIKit

final class HeadlineTableViewCell: UITableViewCell {
    
    static let identifier = "HeadlineTableViewCell"
    
    @IBOutlet weak var firstImage: UIImageView!
    @IBOutlet weak var secondImage: UIImageView!
    @IBOutlet weak var pageControl: UIPageControl!
    
    func setup(headlines: [HeadlineItem]) {
        guard headlines.count == 2 else { return }
        firstImage.load(headlines[0].image)
        secondImage.load(headlines[1].image)
    }
}

extension HeadlineTableViewCell: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let page = scrollView.contentOffset.x / scrollView.frame.width
        pageControl.currentPage = Int(page)
    }
}
