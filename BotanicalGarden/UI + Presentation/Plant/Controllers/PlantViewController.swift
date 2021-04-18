//
//  PlantViewController.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import UIKit

final class PlantViewController: UIViewController {
    
    // MARK: - IBOutlet
    @IBOutlet weak var navigationTopConstraint: NSLayoutConstraint!
    @IBOutlet weak var navigationLabel: UILabel!
    @IBOutlet weak var coverNavigationView: UIView!
    @IBOutlet weak var tableView: UITableView! {
        didSet {
            tableView.dataSource = self
            tableView.delegate = self
        }
    }

    // MARK: - private property
    private let minTop: CGFloat = -180 + 8 + 19.5 + 8 // 19.5 為 label 高度，8 為 label 上下間距
    private var oldContentOffsetY: CGFloat = 0
    
    // MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

// MARK: - UITableViewDataSource
extension PlantViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 50
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }
}

// MARK: - UITableViewDelegate
extension PlantViewController: UITableViewDelegate {
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        changeNavigationPosition()
    }
    
    private func changeNavigationPosition() {
        let offsetY = tableView.contentOffset.y
        let direction = offsetY - oldContentOffsetY
        let constant = navigationTopConstraint.constant

        if direction < 0 && constant < 0 && offsetY < 0 {
            // 下拉
            navigationTopConstraint.constant = ( constant - offsetY <= 0 ) ? constant - offsetY : 0
            changeViewAlpha(with: navigationTopConstraint.constant)
            tableView.contentOffset.y = 0
            
        } else if direction > 0 && constant > minTop && offsetY > 0 {
            // 上滑
            navigationTopConstraint.constant = ( constant - offsetY >= minTop ) ? constant - offsetY : minTop
            changeViewAlpha(with: navigationTopConstraint.constant)
            tableView.contentOffset.y = 0
        }
        oldContentOffsetY = tableView.contentOffset.y
    }
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        guard decelerate == false else { return }
        setNavigationToPosition()
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        setNavigationToPosition()
    }

    private func setNavigationToPosition() {
        guard tableView.contentOffset.y < 10 else { return }
        
        let constant = navigationTopConstraint.constant
        navigationTopConstraint.constant = ( constant >= minTop / 2 ) ? 0 : minTop
        changeViewAlpha(with: navigationTopConstraint.constant)
    }
    
    private func changeViewAlpha(with constant: CGFloat) {
        let alpha = constant / 144.5 + 1
        coverNavigationView.alpha = alpha
        navigationLabel.alpha = 1 - alpha
    }
}
