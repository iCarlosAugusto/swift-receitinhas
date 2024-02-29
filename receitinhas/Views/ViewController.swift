//
//  ViewController.swift
//  receitinhas
//
//  Created by Carlos on 15/02/24.
//

import UIKit

class ViewController: UIViewController, AddCookingViewDelegate {
    private lazy var titleView: UILabel = {
        let title = UILabel()
        title.translatesAutoresizingMaskIntoConstraints = false;
        title.font = UIFont.systemFont(ofSize: 26, weight: .bold)
        title.text = "Minhas receitinhas"
        return title
    }()
    
    private lazy var tableView: UITableView = {
        let table = UITableView();
        table.translatesAutoresizingMaskIntoConstraints = false;
        table.delegate = self;
        table.dataSource = self;
        table.separatorStyle = .none
        //table.register(TableCell.self, forCellReuseIdentifier: "cell")
        return table;
    }()
    
    let addCookingView = AddCookingView()
    
    var cookings: [FoodRecipe] = []
    
    func didCreateNewCooking(food: FoodRecipe) {
        cookings.append(food);
        tableView.reloadData()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        addCookingView.delegate = self
        view.backgroundColor = .white
        setupUI()
        setNavigationBar()
        getCookings()
    }
    
    func getCookings() {
        if let cookings = CookingLocalStorage.get() {
            self.cookings = cookings
            tableView.reloadData()
        };
    }
    
    func setNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "star"),
            style: .plain,
            target: self,
            action: #selector(createNewCooking))
    }
    
     @objc func createNewCooking() {
         present(addCookingView, animated: true)
    }
}

extension ViewController: ViewCode {
    func addSubviews() {
        view.addSubview(titleView)
        view.addSubview(tableView)
    }
    
    func setupConstraints() {
        NSLayoutConstraint.activate([
            titleView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            titleView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 16),
            
            tableView.topAnchor.constraint(equalTo: titleView.bottomAnchor),
            tableView.leftAnchor.constraint(equalTo: view.leftAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.rightAnchor.constraint(equalTo: view.rightAnchor),
        ])
    }
    
    func setupStyle() {
        
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cookings.count;
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cook = cookings[indexPath.row];
        let cell = UITableViewCell();
        cell.textLabel?.text = cook.name
        return cell;
    }
}
