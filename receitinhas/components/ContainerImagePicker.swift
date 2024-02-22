//
//  ContainerImagePicker.swift
//  receitinhas
//
//  Created by Carlos on 16/02/24.
//

import Foundation
import UIKit

protocol ContainerImagePickerDelegate {
    func didTapSelectImage()
}

class ContainerImagePicker: UIView, UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    
    var delegate: ContainerImagePickerDelegate?
    
    lazy var cameraIcon: UIImageView = {
        let imageView = UIImageView();
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "camera")
        return imageView
    }()
    
    override init(frame: CGRect) {
        super.init(frame: .zero)
        self.setupUI()
        self.setupTapGesture()
    }
    
    private func setupTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(handleTap))
        self.addGestureRecognizer(tap)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @objc func handleTap() {
        delegate?.didTapSelectImage();
    }
}

extension ContainerImagePicker: ViewCode {
    func addSubviews() {
        self.addSubview(cameraIcon)
    }
    
    func setupConstraints() {
        self.translatesAutoresizingMaskIntoConstraints = false;
        NSLayoutConstraint.activate([
            self.widthAnchor.constraint(equalToConstant: 100),
            self.heightAnchor.constraint(equalToConstant: 100),
            
            cameraIcon.centerYAnchor.constraint(equalTo: self.centerYAnchor),
            cameraIcon.centerXAnchor.constraint(equalTo: self.centerXAnchor)
        ])
    }
    
    func setupStyle() {
        self.backgroundColor = .systemGray2
        self.layer.cornerRadius = 6
    }
}
