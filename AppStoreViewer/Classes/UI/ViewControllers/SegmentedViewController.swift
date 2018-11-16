//
//  SegmentedViewController.swift
//  AppStoreViewer
//
//  Created by Gil Nakache on 16/11/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import UIKit

public class SegmentedViewController: UIViewController {

    // MARK: - Public variables

    /// List of ViewControllers. View Controller Titles are used as segment titles.
    public var items = [UIViewController]() {
        didSet {
            // Remove previous viewControllers
            for previousItem in oldValue {
                self.remove(viewControllerToRemove: previousItem)
            }
            // Remove segments
            segmentedControl.removeAllSegments()

            // Add new segments and first viewController
            for (index, item) in items.enumerated() {
                segmentedControl.insertSegment(withTitle: item.title, at: index, animated: false)

                if index == 0 {
                    segmentedControl.selectedSegmentIndex = 0
                    selectController(at: index)
                }
            }
        }
    }

    // MARK: - Private variables

    private let segmentedControl = UISegmentedControl()
    private let containerView = UIView()
    private let stackView = UIStackView()
    private let topStackView = UIStackView()

    // MARK: - LifeCycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        topStackView.axis = .vertical
        topStackView.alignment = .center
        topStackView.distribution = .equalSpacing
        topStackView.isLayoutMarginsRelativeArrangement = true
        topStackView.preservesSuperviewLayoutMargins = true

        view.backgroundColor = .white
        stackView.axis = .vertical
        stackView.distribution = .fill
        stackView.alignment = .fill
        stackView.spacing = 5

        view.addSubview(stackView)
        view.anchor(view: stackView, useSafeAnchors: false)

        stackView.addArrangedSubview(topStackView)
        topStackView.addArrangedSubview(segmentedControl)
        stackView.addArrangedSubview(containerView)

        segmentedControl.addTarget(self, action: #selector(segmentDidChange(segment:)), for: .valueChanged)
    }

    // MARK: - Actions

    @objc
    private func segmentDidChange(segment: UISegmentedControl) {

        selectController(at: segment.selectedSegmentIndex)

        print(segment.selectedSegmentIndex)
    }

    private func selectController(at index: Int ) {

        let item = items[index]

        add(asChildViewController: item, anchored: true, subview: containerView)
    }
}
