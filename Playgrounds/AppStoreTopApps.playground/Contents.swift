import PlaygroundSupport
import UIKit

@testable import AppStoreFramework



public class AppsViewCoordinator1: UIViewController, UITableViewDelegate {

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

public class RootAppsCoordinator: UIViewController, UINavigationControllerDelegate {
    // MARK: - Private variables

    private let segmentedViewController = SegmentedViewController()

    private let freeAppsViewCoordinator = AppsViewCoordinator1()

    private let paidAppsViewCoordinator = AppsViewCoordinator1()

    private lazy var navController = UINavigationController(rootViewController: segmentedViewController)

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

PlaygroundPage.current.liveView = RootAppsCoordinator()
