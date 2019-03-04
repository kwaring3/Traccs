//
//  UserDonationsDetailViewController.swift
//  Traccs
//
//  Created by Kevin Waring on 2/14/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import UIKit

class UserDonationsDetailViewController: UIViewController {

    var create: Create!
    var updates1 =  [Update]() {
        didSet{
            DispatchQueue.main.async {
                self.updatesTableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var updatesTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatesTableView.dataSource = self

        
    }
    

   

}
extension UserDonationsDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return updates1.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        updatesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UpdatesCell")
        
        var cell = updatesTableView.dequeueReusableCell(withIdentifier: "UpdatesCell", for: indexPath as IndexPath)
        cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                               reuseIdentifier: "UpdatesCell")
        cell.textLabel?.text = updates1[indexPath.row].updatesTitle
        cell.detailTextLabel?.text =  updates1[indexPath.row].updates
        return cell
    }
    
    
    
    
    
    
}

