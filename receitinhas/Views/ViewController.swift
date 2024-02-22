//
//  ViewController.swift
//  receitinhas
//
//  Created by Carlos on 15/02/24.
//

import UIKit

class ViewController: UIViewController {
    
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
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .white
        setupUI()

        setNavigationBar()
    }
    
    func setNavigationBar() {
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(
            image: UIImage(systemName: "star"),
            style: .plain,
            target: self,
            action: #selector(createNewCooking))
    }
    
     @objc func createNewCooking() {
         let vc = AddCookingView();
         present(vc, animated: true)
         //self.navigationController?.pushViewController(vc, animated: true)
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
        return 5;
    }

    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell();
        cell.textLabel?.text = "Teste"
        return cell;
    }
}
