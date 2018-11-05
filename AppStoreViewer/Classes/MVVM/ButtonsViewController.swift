//
//  ButtonsViewController.swift
//  AppStoreViewer
//
//  Created by Gil Nakache on 05/11/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public class ButtonsViewController: UIViewController {

    let disposeBag = DisposeBag()
    let firstNameTextField = UITextField()

    let lastNameTextField = UITextField()

    let ageTextField = UITextField()

    let button = UIButton(type: .custom)

    let firstStack = UIStackView()
    let stackView = UIStackView()

    let viewModel = ButtonsViewModel()

    let label = UILabel()

    // MARK: - Lifecycle

    public override func viewDidLoad() {
        super.viewDidLoad()

        view.backgroundColor = UIColor.white
        stackView.axis = .vertical
        stackView.alignment = .center
        stackView.spacing = 10
        stackView.distribution = .fill

        firstStack.axis = .horizontal
        firstStack.alignment = .top
        view.addSubview(firstStack)
        firstStack.addArrangedSubview(stackView)

        firstNameTextField.placeholder = "Prénom"
        lastNameTextField.placeholder = "Nom"
        ageTextField.placeholder = "Age"

        button.setTitle("Button", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.red, for: .disabled)
        stackView.addArrangedSubview(firstNameTextField)
        stackView.addArrangedSubview(lastNameTextField)
        stackView.addArrangedSubview(ageTextField)

        stackView.addArrangedSubview(button)

        view.anchor(view: firstStack)

        bindViewModel()

    }

    private func bindViewModel() {

        firstNameTextField.rx.text.orEmpty.bind(to: viewModel.firstName).disposed(by: disposeBag)
        lastNameTextField.rx.text.orEmpty.bind(to: viewModel.lastName).disposed(by: disposeBag)

        ageTextField.rx.text.orEmpty.bind(to: viewModel.age).disposed(by: disposeBag)

        viewModel.isEnabled.bind(to: button.rx.isEnabled).disposed(by: disposeBag)

    }

}
