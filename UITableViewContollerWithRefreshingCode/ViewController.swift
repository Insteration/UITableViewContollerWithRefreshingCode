//
//  ViewController.swift
//  UITableViewContollerWithRefreshingCode
//
//  Created by Артём Кармазь on 5/24/19.
//  Copyright © 2019 Artem Karmaz. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var refresh: UIRefreshControl!
    var tableViewController :UITableViewController!
    
    let cellId = "Cell"
    
    var allTime = [Date]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableViewController = UITableViewController(style: .plain)
        tableViewController.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        tableViewController.tableView.delegate = self
        tableViewController.tableView.dataSource = self
        
        refresh = UIRefreshControl()
        refresh.addTarget(self, action: #selector(handleRefresh), for: .valueChanged)
        refresh.tintColor = .red
        
        tableViewController.tableView.addSubview(refresh)
        view.addSubview(tableViewController.tableView)
    }

    @objc func handleRefresh() {
        allTime.append(Date())
        refresh.endRefreshing()
        
        let indexPathNewRow = IndexPath(row: allTime.count - 1, section: 0)
        tableViewController.tableView.insertRows(at: [indexPathNewRow], with: .automatic)
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        cell.textLabel?.text = "\(allTime[indexPath.row])"
        return cell
    }
}
