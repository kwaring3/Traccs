//
//  AdminActiveCausesDetailViewController.swift
//  Traccs
//
//  Created by Kevin Waring on 2/14/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import UIKit

class AdminActiveCausesDetailViewController: UIViewController {

    public var create: AdminCause!
    var causes = DataPersistenceModel.get()
    var causeInfo: AdminCause?
    
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
        updateTableView.delegate = self
        setupPage()



        
    }
    
    private func setupPage() {
        self.detailLabel.text = causeInfo?.title

        if let words = causeInfo?.causeDescription {
            detailTextView.text = "\(words)"
        } else {
            detailTextView.text = "N/A"
        }
        //self.detailTextView.text = causeInfo?.causeDescription
        self.detailImageView.image = (UIImage(data: (causeInfo?.image)!))
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
extension AdminActiveCausesDetailViewController: UITableViewDataSource, UITableViewDelegate {
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let tableViewDetail = storyboard.instantiateViewController(withIdentifier: "TableViewDetail") as? AdminTableViewDetailViewController else {print("NO VC")
            return
        }
        let tableViewInfoToSend = update[indexPath.row]
        tableViewDetail.update = tableViewInfoToSend
        tableViewDetail.modalPresentationStyle = .fullScreen
        present(tableViewDetail, animated: true, completion: nil)
    }
    
    

    
    
    
}
