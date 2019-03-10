//
//  UserDonationsDetailViewController.swift
//  Traccs
//
//  Created by Kevin Waring on 2/14/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import UIKit

class UserDonationsDetailViewController: UIViewController {
    public var create1: AdminCause!{
        didSet {
            if updatesTableView != nil {
                update = create1.update1.sorted { (firstPair, secondPair) -> Bool in
                    let format = DateFormatter()
                    guard let firstTimestamp = format.date(from: firstPair.key),
                        let secondTimestamp = format.date(from: secondPair.key) else {return false}
                    return firstTimestamp < secondTimestamp
                }
                
            }
        }
    }
    var create: Donate!
    var updates1 =  [Update]() {
        didSet{
            DispatchQueue.main.async {
                self.updatesTableView.reloadData()
            }
        }
    }
    var update =  [(String , String)]() {
        didSet{
            DispatchQueue.main.async {
                self.updatesTableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var updatesTableView: UITableView!
    @IBOutlet weak var amountLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updatesTableView.dataSource = self
        setupPage()
//      guard let update = create1.update1.sorted { (firstPair, secondPair) -> Bool in
//            let format = DateFormatter()
//            guard let firstTimestamp = format.date(from: firstPair.key),
//                let secondTimestamp = format.date(from: secondPair.key) else {return false}
//            return firstTimestamp < secondTimestamp
//        }
    }
    private func setupPage() {
        self.detailLabel.text = create.causeTitle
        self.detailTextView.text = create.causeDescription
        self.amountLabel.text = "You donated: \(self.create.donationAmount) Dollars"
        
    }

    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
extension UserDonationsDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return update.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        updatesTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UpdatesCell")
        
        var cell = updatesTableView.dequeueReusableCell(withIdentifier: "UpdatesCell", for: indexPath as IndexPath)
        cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                               reuseIdentifier: "UpdatesCell")
        cell.textLabel?.text = update[indexPath.row].0
        
         cell.detailTextLabel?.text = update[indexPath.row].1
        
        return cell
    }
    
    
    
    
    
    
}

