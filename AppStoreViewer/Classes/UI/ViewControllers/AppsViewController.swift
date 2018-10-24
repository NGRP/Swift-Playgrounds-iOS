//
//  AppsViewController.swift
//  AppStoreViewer
//
//  Created by Gil Nakache on 24/10/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import UIKit

public protocol Listable {
    var text: String { get }
    var longText: String { get }
    var imageUrl: String { get }
}

class AppsViewController: UITableViewController {

    // MARK: - Variables

    public var list = [Listable]() {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        tableView.register(ImageAndTextTableViewCell.self, forCellReuseIdentifier: ImageAndTextTableViewCell.defaultReuseIdentifier)
    }

    override func tableView(_: UITableView, numberOfRowsInSection _: Int) -> Int {
        return list.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: ImageAndTextTableViewCell.defaultReuseIdentifier, for: indexPath)

        let element = list[indexPath.row]

        if let imageCell = cell as? ImageAndTextTableViewCell {
            imageCell.label.text = element.text
            imageCell.rightImageView.url = URL(string:element.imageUrl)
        }

        return cell
    }
}
