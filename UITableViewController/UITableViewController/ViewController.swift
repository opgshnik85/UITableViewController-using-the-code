//
//  ViewController.swift
//  UITableViewController
//
//  Created by MacBook on 15.02.2022.
//

import UIKit

class ViewController: UIViewController {
    
    let tableViewController = UITableViewController(style: .plain)
    var refresh = UIRefreshControl()
    
    var allTime = [Date]()
    var cellidentifire = "Cell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        createTableView()
        
        self.refresh.addTarget(self, action: #selector(handlerefresh), for: .valueChanged)
        self.refresh.tintColor = UIColor.systemRed
        
        view.addSubview(tableViewController.tableView)
        tableViewController.tableView.addSubview(refresh)
    }
    
    @objc func handlerefresh() {
        allTime.append(Date())
        refresh.endRefreshing()
        let indexPathNewRow = IndexPath(row: allTime.count - 1, section: 0)
        tableViewController.tableView.insertRows(at: [indexPathNewRow], with: .automatic)
    }
    
    func createTableView() {
        tableViewController.tableView = UITableView(frame: view.bounds, style: .plain)
        tableViewController.tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellidentifire)
        tableViewController.tableView.delegate = self
        tableViewController.tableView.dataSource = self
    }
}

extension ViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return allTime.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellidentifire, for: indexPath)
        let date = allTime[indexPath.row]
        
        cell.textLabel?.text = "\(date)"
        
        return cell
    }
}

