//
//  RootAppsCoordinator.swift
//  AppStoreViewer
//
//  Created by Gil Nakache on 16/11/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import UIKit

public class RootAppsCoordinator: UIViewController, UINavigationControllerDelegate {
    // MARK: - Private variables

    private let segmentedViewController = SegmentedViewController()
    private let freeAppsViewCoordinator = AppsViewCoordinator()
    private let paidAppsViewCoordinator = AppsViewCoordinator()
    private lazy var navController = UINavigationController(rootViewController: segmentedViewController)

    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        navController.delegate = self

        freeAppsViewCoordinator.appType = .free
        paidAppsViewCoordinator.appType = .paid

        add(asChildViewController: navController)

        segmentedViewController.items = [freeAppsViewCoordinator, paidAppsViewCoordinator]
    }

    // MARK: - UINavigationControllerDelegate

    public func navigationController(_ navigationController: UINavigationController, willShow viewController: UIViewController, animated: Bool) {
        // Allows hiding the navigation bar for the rootViewController
        let hide = viewController == navigationController.viewControllers.first
        navigationController.setNavigationBarHidden(hide, animated: animated)
    }
}
