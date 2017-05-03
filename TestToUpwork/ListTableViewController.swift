//
//  ListTableViewController.swift
//  TestToUpwork
//
//  Created by Andrey Elpaev on 02/05/2017.
//  Copyright © 2017 ClearSofrware. All rights reserved.
//

import UIKit

protocol MarkerDelegate: class {
    func didTap(_ id: Int)
}


class ListTableViewController: UITableViewController {
    
    var type: Type!
    weak var delegate: MarkerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.tableFooterView = UIView()
        
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return fuelingList.count
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let cell = cell as! ListTableViewCell
        
        cell.nameLabel.text = fuelingList[indexPath.row].name
        cell.addressLabel.text = fuelingList[indexPath.row].address
        cell.costLabel.text = fuelingList[indexPath.row].cost.appending(" ₽")
        cell.distanceLabel.text = fuelingList[indexPath.row].distance
        cell.timeLabel.text = fuelingList[indexPath.row].time
        
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        delegate?.didTap(fuelingList[indexPath.row].id)
        
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        return cell
    }
}
