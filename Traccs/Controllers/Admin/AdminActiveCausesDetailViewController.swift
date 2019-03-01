//
//  AdminActiveCausesDetailViewController.swift
//  Traccs
//
//  Created by Kevin Waring on 2/14/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import UIKit

class AdminActiveCausesDetailViewController: UIViewController {

    public var create: Create!
    var causes = DataPersistenceModel.get()
    var causeInfo: Create?
    
    var update =  [Update]() {
        didSet{
            DispatchQueue.main.async {
                self.updateTableView.reloadData()
            }
        }
    }
    
    @IBOutlet weak var detailImageView: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var detailTextView: UITextView!
    @IBOutlet weak var updateTextView: UITextView!
    @IBOutlet weak var updateTableView: UITableView!
    @IBOutlet weak var updateTextField: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateTableView.dataSource = self
        setupPage()



        
    }
    
    private func setupPage() {
        self.detailLabel.text = causeInfo?.title
        self.detailTextView.text = causeInfo?.causeDescription
        self.updateTextView.text = "Enter Update Here"

    }
    public func save() {

        if let textTitle = self.updateTextView.text {
            if let textTitle1 = self.updateTextField.text {
            let newUpdate = Update.init(updatesTitle: textTitle1, updates: textTitle)
        update.append(newUpdate)
        }
        }
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func updateButtonPressed(_ sender: UIButton) {
        save()
    }
    

}
extension AdminActiveCausesDetailViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return update.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        updateTableView.register(UITableViewCell.self, forCellReuseIdentifier: "UpdateCell")
        
        var cell = updateTableView.dequeueReusableCell(withIdentifier: "UpdateCell", for: indexPath as IndexPath)
        cell = UITableViewCell(style: UITableViewCell.CellStyle.subtitle,
                               reuseIdentifier: "UpdateCell")
        cell.textLabel?.text = update[indexPath.row].updatesTitle
        cell.detailTextLabel?.text =  update[indexPath.row].updates
        return cell
    }
    
    

    
    
    
}
