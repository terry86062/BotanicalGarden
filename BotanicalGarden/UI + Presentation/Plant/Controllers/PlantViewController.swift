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
            tableView.prefetchDataSource = self
            tableView.delegate = self
            tableView.register(PlantTableViewCell.self)
        }
    }

    // MARK: - private property
    private let minTop: CGFloat = -180 + 8 + 19.5 + 8 // 19.5 為 label 高度，8 為 label 上下間距
    private var oldContentOffsetY: CGFloat = 0
    private let viewModel: PlantViewModel
    
    // MARK: - init
    init(viewModel: PlantViewModel) {
        self.viewModel = viewModel
        
        super.init(nibName: nil, bundle: nil)
    }
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    // MARK: - override func
    override func viewDidLoad() {
        super.viewDidLoad()
        
        binded()
        viewModel.inputs.loadPlant()
    }
    
    private func binded() {
        var outputs = viewModel.outputs
        
        outputs.didLoadPlant = { [weak self] indexPaths in
            self?.tableView.insertRows(at: indexPaths, with: .none)
        }
    }
}

// MARK: - UITableViewDataSource
extension PlantViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.outputs.items.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(PlantTableViewCell.self, for: indexPath)
        let item = viewModel.outputs.items[indexPath.row]
        cell.configure(imageURL: item.imageURL, name: item.name, location: item.location, feature: item.feature)
        return cell
    }
}

// MARK: - UITableViewDataSourcePrefetching
extension PlantViewController: UITableViewDataSourcePrefetching {
    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath]) {
        indexPaths.forEach { indexPath in
            let cell = tableView.cellForRow(at: indexPath) as? PlantTableViewCell
            let item = viewModel.outputs.items[indexPath.row]
            cell?.configure(imageURL: item.imageURL)
        }
    }
}

// MARK: - UITableViewDelegate
extension PlantViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = viewModel.outputs.items[indexPath.row]
        return item.height
    }
    
    func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        let item = viewModel.outputs.items[indexPath.row]
        return item.height
    }
    
    // MARK: - UIScrollViewDelegate
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        changeNavigationPosition()
        scrollToLoadMore()
    }
    
    private func scrollToLoadMore() {
        guard tableView.isDragging else { return }
        let contentHeight = tableView.contentSize.height
        if tableView.contentOffset.y > contentHeight - tableView.frame.height {
            viewModel.inputs.loadPlant()
        }
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
