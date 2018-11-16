//
//  AppsViewCoordinator.swift
//  AppStoreViewer
//
//  Created by Gil Nakache on 24/10/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import UIKit

public class AppsViewCoordinator: UIViewController, UITableViewDelegate {
    // MARK: - Public Variables

    public var appType: AppType = .free {
        didSet {
            title = appType.rawValue
        }
    }

    // MARK: - Private Variables

    private let appsViewController = ListViewController()

    private var apps = [App]()

    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        title = appType.rawValue
        appsViewController.tableView.delegate = self

        add(asChildViewController: appsViewController)
    }

    public override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        let ressource = AppStoreRessource()

        ressource.getApps(top: 100, appType: appType) { apps, _ in
            //
            self.apps = apps
            self.appsViewController.list = apps
        }
    }

    // MARK: - UITableViewDelegate

    public func tableView(_: UITableView, didSelectRowAt indexPath: IndexPath) {
        let detailViewController = DetailViewController()

        let detail = apps[indexPath.row]

        detailViewController.detail = detail
        navigationController?.pushViewController(detailViewController, animated: true)
    }
}
