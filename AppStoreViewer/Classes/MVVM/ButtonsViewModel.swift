//
//  ButtonsViewModel.swift
//  AppStoreViewer
//
//  Created by Gil Nakache on 05/11/2018.
//  Copyright © 2018 Viseo. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa

public class ButtonsViewModel {

    var firstName = BehaviorRelay<String>( value: "")
    var lastName = BehaviorRelay<String>( value: "")
    var age = BehaviorRelay<String>( value: "")

    var isEnabled: Observable<Bool> {
        return Observable.combineLatest(firstName,lastName,age) { firstName, lastName, age in
            return firstName.count > 0 && lastName.count > 0 && age.count > 0
        }
    }
}

