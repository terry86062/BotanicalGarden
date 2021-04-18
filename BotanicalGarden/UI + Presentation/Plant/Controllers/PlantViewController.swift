//
//  PlantViewController.swift
//  BotanicalGarden
//
//  Created by 黃偉勛 Terry on 2021/4/18.
//

import UIKit

class PlantViewController: UIViewController {
    
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
extension PlantViewController: UITableViewDelegate {}
