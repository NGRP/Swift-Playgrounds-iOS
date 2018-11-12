import UIKit
import PlaygroundSupport

@testable import AppStoreFramework
import RxSwift
import RxCocoa


public struct UserModel {
    let firstName: String
    let lastName: String
    let age: Int
}

public class ButtonsViewController: UIViewController {

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

//        firstStack.axis = .horizontal
//        firstStack.alignment = .top
        view.addSubview(stackView)
    //firstStack.addArrangedSubview(stackView)

        firstNameTextField.placeholder = "Prénom"
        lastNameTextField.placeholder = "Nom"
        ageTextField.placeholder = "Age"

        button.setTitle("Button", for: .normal)
        button.setTitleColor(UIColor.black, for: .normal)
        button.setTitleColor(UIColor.white, for: .disabled)
        stackView.addArrangedSubview(firstNameTextField)
        stackView.addArrangedSubview(lastNameTextField)
        stackView.addArrangedSubview(ageTextField)

        stackView.addArrangedSubview(button)

        bindViewModel()

        view.anchor(view: stackView)

        //bindViewModel()

    }

    private func bindViewModel() {

        firstNameTextField.rx.text.orEmpty.bind(to: viewModel.firstName)
        lastNameTextField.rx.text.orEmpty.bind(to: viewModel.lastName)

        ageTextField.rx.text.orEmpty.bind(to: viewModel.age)

        viewModel.isEnabled.bind(to: button.rx.isEnabled)

    }

}

public class ButtonsViewModel {

    var firstName = BehaviorRelay<String>( value: "")

       var lastName = BehaviorRelay<String>( value: "")
       var age = BehaviorRelay<String>( value: "")

    var isEnabled: Observable<Bool> {
        return Observable.combineLatest(firstName,lastName,age) { firstName, lastName, age in
            return firstName.count > 0
        }
    }
}


PlaygroundPage.current.liveView = ButtonsViewController()
