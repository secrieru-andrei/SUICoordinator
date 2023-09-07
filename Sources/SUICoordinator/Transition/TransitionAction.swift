//
//  File.swift
//  
//
//  Created by Secrieru Andrei on 07.09.2023.
//

import SwiftUI

public enum TransitionAction {
    case push(animated: Bool)
    case present(
        animated: Bool,
        modalPresentationStyle: UIModalPresentationStyle = .automatic,
        completion: (() -> Void)? = nil
    )
}
