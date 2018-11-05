@testable import AppStoreFramework
import PlaygroundSupport
import UIKit

public class SectionTableViewController: UITableViewController {
    // MARK: - Variables

    public var sections = [[String: [String]]]() {
        didSet {
            tableView.reloadData()
        }
    }

    // MARK: - LifeCycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        tableView.register(UITableViewCell.self, forCellReuseIdentifier: UITableViewCell.defaultReuseIdentifier)

        //tableView.delegate
    }

    // MARK: - Variables

    public override func numberOfSections(in _: UITableView) -> Int {
        return sections.count
    }

    public override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sections[section].values.first?.count ?? 0
    }

    public override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: UITableViewCell.defaultReuseIdentifier, for: indexPath)

        cell.textLabel?.text = sections[indexPath.section].values.first?[indexPath.row]

        return cell
    }

    public override func tableView(_: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section].keys.first
    }
}

public protocol ScrollHeaderControllerDelegate: class {
    func scrollHeaderController(scrollHeaderController: ScrollHeaderController, didTapItemAt index: Int)
}

public class ScrollHeaderController: UIViewController {
    // MARK: - Public Variables

    public weak var delegate: ScrollHeaderControllerDelegate?

    public var items = [String]() {
        didSet {

            for item in items {
                let label = UILabel()
                label.layer.cornerRadius = 5
                label.layer.masksToBounds = true
                label.backgroundColor = UIColor.white
                label.textColor = UIColor.black
                label.text = item

                let tapGesture = UITapGestureRecognizer(target: self, action: #selector(labelDidTap(gesture:)))

                label.addGestureRecognizer(tapGesture)
                label.isUserInteractionEnabled = true

                stackView.addArrangedSubview(label)
            }
        }
    }

    public var selectedItemIndex: Int = 0 {
        didSet {
            guard let label = stackView.arrangedSubviews[selectedItemIndex] as? UILabel else { return }

            label.backgroundColor = UIColor.black
            label.textColor = UIColor.white

            scrollView.scrollRectToVisible(label.frame, animated: true)

            lastLabel?.backgroundColor = UIColor.white
            lastLabel?.textColor = UIColor.black

            lastLabel = label
        }
    }

    // MARK: - Private Variables

    private var lastLabel: UILabel?

    private var stackView = UIStackView()

    private let scrollView = UIScrollView()

    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white

        stackView = UIStackView()
        stackView.axis = .horizontal

        stackView.alignment = .fill
        stackView.spacing = 30
        stackView.isLayoutMarginsRelativeArrangement = true
        stackView.layoutMargins = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)

        view.addSubview(scrollView)

        view.anchor(view: scrollView)

        scrollView.addSubview(stackView)

        scrollView.anchor(view: stackView, useSafeAnchors: false)
    }

    // MARK: - Actions

    @objc
    private func labelDidTap(gesture: UITapGestureRecognizer) {
        guard let label = gesture.view,
            let index = stackView.arrangedSubviews.index(of: label)
        else { return }


       self.selectedItemIndex = index
        delegate?.scrollHeaderController(scrollHeaderController: self, didTapItemAt: index)
        print(index)
    }
}

public class UberCoordinator: UIViewController, UITableViewDelegate, ScrollHeaderControllerDelegate {
    // MARK: - variables

    private var section = 0

    private let hardCodedData = [
        ["Section 1": ["Ligne 1", "Ligne 2", "Ligne 3"]],
        ["Section 2": ["Ligne 1", "Ligne 2"]],
        ["Section 3": ["Ligne 1", "Ligne 2", "Ligne 3", "Ligne 4", "Ligne 5", "Ligne 6"]],
        ["Section 4": ["Ligne 1", "Ligne 2", "Ligne 3", "Ligne 4", "Ligne 5", "Ligne 6", "Ligne 7"]],
        ["Section 5": ["Ligne 1", "Ligne 2", "Ligne 3", "Ligne 4", "Ligne 5", "Ligne 6", "Ligne 7"]],
        ["Section 6": ["Ligne 1", "Ligne 2", "Ligne 3"]],
    ]

    let sectionTableViewController = SectionTableViewController()

    let scrollViewController = ScrollHeaderController()

    // MARK: - LifeCycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        scrollViewController.delegate = self

        add(asChildViewController: scrollViewController, anchored: false)

        sectionTableViewController.sections = hardCodedData

        sectionTableViewController.tableView.delegate = self

        add(asChildViewController: sectionTableViewController, anchored: false)

        view.anchor(views: [scrollViewController.view, sectionTableViewController.view])
        scrollViewController.view.heightAnchor.constraint(equalToConstant: 50).isActive = true

        scrollViewController.items = hardCodedData.map {
            $0.keys.first!
        }
    }

    // MARK: - UITableViewDelegate

    public func tableView(_: UITableView, willDisplayHeaderView _: UIView, forSection section: Int) {

        if self.section > section {
            scrollViewController.selectedItemIndex = section
            self.section = section
        }
        print(section)
    }

    public func tableView(_: UITableView, didEndDisplayingHeaderView _: UIView, forSection section: Int) {
        print("end display \(section)")

        if self.section == section {
            scrollViewController.selectedItemIndex = section + 1
            self.section = section + 1
        }
    }

    // MARK: - ScrollHeaderControllerDelegate

    public func scrollHeaderController(scrollHeaderController _: ScrollHeaderController, didTapItemAt index: Int) {
        sectionTableViewController.tableView.scrollToRow(at: IndexPath(row: 0, section: index), at: .top, animated: true)
            section = index
    }
}

let uberCoordinator = UberCoordinator()
PlaygroundPage.current.liveView = uberCoordinator
