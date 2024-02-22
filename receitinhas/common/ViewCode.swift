//
//  ViewCode.swift
//  receitinhas
//
//  Created by Carlos on 15/02/24.
//

import Foundation

protocol ViewCode {
    func addSubviews()
    func setupConstraints()
    func setupStyle()
}

extension ViewCode {
    func setupUI() {
        addSubviews()
        setupStyle()
        setupConstraints()
    }
}
