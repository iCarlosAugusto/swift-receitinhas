//
//  AddCookingView.swift
//  receitinhas
//
//  Created by Carlos on 15/02/24.
//

import Foundation
import UIKit

protocol AddCookingViewDelegate {
    func didCreateNewCooking(food: FoodRecipe)
}

class AddCookingView: UIViewController, ContainerImagePickerDelegate {
    
    let userDefaults = UserDefaults.standard;
    var delegate: AddCookingViewDelegate?;
    
    private lazy var titleView: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false
        title.text = "Crie uma nova receita"
        title.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        return title
    }()
    
    private lazy var titleTextfieldView: UITextField = {
        let titleTextfield = UITextField();
        titleTextfield.delegate = self;
        titleTextfield.translatesAutoresizingMaskIntoConstraints = false
        titleTextfield.placeholder = "Título"
        titleTextfield.font = UIFont.systemFont(ofSize: 15)
        titleTextfield.borderStyle = UITextField.BorderStyle.roundedRect
        titleTextfield.clearButtonMode = UITextField.ViewMode.whileEditing
        return titleTextfield;
    }()
    
    private lazy var descriptionTextfieldView: UITextField = {
        let descriptionTextfield = UITextField();
        descriptionTextfield.translatesAutoresizingMaskIntoConstraints = false
        descriptionTextfield.placeholder = "Descrição"
        descriptionTextfield.font = UIFont.systemFont(ofSize: 15)
        descriptionTextfield.borderStyle = UITextField.BorderStyle.roundedRect
        descriptionTextfield.clearButtonMode = UITextField.ViewMode.whileEditing
        return descriptionTextfield;
    }()
    
    private lazy var buttonSubmitView: UIButton = {
        let button = UIButton();
        button.addTarget(self, action: #selector(createCooking), for: .touchDown)
        button.isEnabled = false;
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Criar", for: .normal)
        button.configuration?.titlePadding = 16
        button.backgroundColor = .blue;
        button.layer.cornerRadius = 6
        return button;
    }()
    
    private lazy var imageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(systemName: "questionmark")
        imageView.tintColor = .label
        imageView.isHidden = true;
        imageView.backgroundColor = .gray
        return imageView
    }()
    
    let containerImagePicker = ContainerImagePicker()
    
    func enableSubmitButton(value: Bool) {
        buttonSubmitView.isEnabled = value
    }
    
    @objc func createCooking() {
        if let title = titleTextfieldView.text, let description = descriptionTextfieldView.text {
            let food = FoodRecipe(name: title, description: description, photo: "1")
            CookingLocalStorage.save(food: food)
            delegate?.didCreateNewCooking(food: food);
            dismiss(animated: true);
        }
    }
        
    func didTapSelectImage() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .savedPhotosAlbum
        imagePicker.allowsEditing = false
        
        present(imagePicker, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        
        setupUI()
        containerImagePicker.delegate = self;
    }
    
}
extension AddCookingView: ViewCode {
    func addSubviews() {
        view.addSubview(titleView)
        view.addSubview(titleTextfieldView)
        view.addSubview(descriptionTextfieldView)
        view.addSubview(buttonSubmitView)
        view.addSubview(imageView)
        view.addSubview(containerImagePicker)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 16),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            titleTextfieldView.topAnchor.constraint(equalTo: titleView.bottomAnchor, constant: 16),
            titleTextfieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            titleTextfieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            descriptionTextfieldView.topAnchor.constraint(equalTo: titleTextfieldView.bottomAnchor, constant: 16),
            descriptionTextfieldView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            descriptionTextfieldView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
            
            containerImagePicker.topAnchor.constraint(equalTo: descriptionTextfieldView.bottomAnchor, constant: 16),
            containerImagePicker.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            containerImagePicker.widthAnchor.constraint(equalToConstant: 100),
            containerImagePicker.heightAnchor.constraint(equalToConstant: 100),
            
            imageView.topAnchor.constraint(equalTo: descriptionTextfieldView.bottomAnchor, constant: 16),
            imageView.leadingAnchor.constraint(equalTo: containerImagePicker.trailingAnchor, constant: 16),
            imageView.widthAnchor.constraint(equalToConstant: 100),
            imageView.heightAnchor.constraint(equalToConstant: 100),
            
            buttonSubmitView.topAnchor.constraint(equalTo: containerImagePicker.bottomAnchor, constant: 16),
            buttonSubmitView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            buttonSubmitView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -16),
        ])
    }
    
    func setupStyle() {
        
    }
}

extension AddCookingView: UIImagePickerControllerDelegate & UINavigationControllerDelegate {
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let image = info[.originalImage] as! UIImage
        self.imageView.image = image;
        self.imageView.isHidden = false;
        self.dismiss(animated: true)
    }
}

extension AddCookingView: UITextFieldDelegate {
    func textFieldDidChangeSelection(_ textField: UITextField) {
        if textField.text?.isEmpty == false {
            enableSubmitButton(value: true)
        } else {
            enableSubmitButton(value: false)
        }
    }
}
