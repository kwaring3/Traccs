//
//  AdminActiveCausesDetailViewController.swift
//  Traccs
//
//  Created by Kevin Waring on 2/14/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import UIKit

class AdminActiveCausesDetailViewController: UIViewController {

    public var create: AdminCause!{
        didSet {
            if updateTableView != nil {
                update = create.update1.sorted { (firstPair, secondPair) -> Bool in
                    let format = DateFormatter()
                    guard let firstTimestamp = format.date(from: firstPair.key),
                        let secondTimestamp = format.date(from: secondPair.key) else {return false}
                    return firstTimestamp < secondTimestamp
                }

            }
        }
    }
    
    var causes = DataPersistenceModel.get()
    
    var usersession: UserSession!
    var neededURL: URL!

    
    var update =  [(String , String)]() {
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
        update = create.update1.sorted { (firstPair, secondPair) -> Bool in
            let format = DateFormatter()
          guard let firstTimestamp = format.date(from: firstPair.key),
            let secondTimestamp = format.date(from: secondPair.key) else {return false}
            return firstTimestamp < secondTimestamp
        }



        
    }
    
    private func setupPage() {
        self.detailLabel.text = create.title

        if let words = create.causeDescription {
            detailTextView.text = "\(words)"
        } else {
            detailTextView.text = "N/A"
        }
        ImageHelper.fetchImageFromNetwork(urlString:create.image.absoluteString ?? "") { (error, image) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                }else if let image = image {
                    self.detailImageView.image = image
                }
            }
        }
        //self.detailTextView.text = causeInfo?.causeDescription
        //self.detailImageView.image = (UIImage(data: (causeInfo?.image)!))
        self.updateTextView.text = "Enter Update Here"

    }
    
    
    public func save() {
        let timeStamp = Date.getISOTimestamp()
        
        guard let causeTitle = detailLabel.text,
            let causeDescription = detailTextView.text,
//            let updateTitle = create.createdAt,
            let updateDescription = updateTextView.text,
            
            
            
            !causeTitle.isEmpty, !causeDescription.isEmpty else {
                return
        }
        create.update1[timeStamp] = updateDescription
       
        DatabaseManager.firebaseDB.collection("causes").document(create.createdAt).setData(["causeTitle" : causeTitle,
                                                                     "causeDescription" : causeDescription,
                                                                     "causeImageURL" : create.image.description,
                                                                     "createdAt" : create.createdAt,
                                                                     "update1" : create.update1
                                                                     ]) { (error) in
                                                                        if let error = error {
                                                                                                print("dontation posting error: \(error.localizedDescription)")
                                                                                            } else {
                                                                                                print("donations post successufully")
                                                                                            }
        }
        
//        DatabaseManager.firebaseDB
//            .collection("causes")
//            .addDocument(data: ["causeTitle"        : causeTitle,
//                                "causeDescription"  : causeDescription,
//                                "causeImageURL"     : detailImageView.absoluteString,
//                                "causeId"           : ""  ,
//                                "createdAt"         : Date.getISOTimestamp(),
//                                "updateTitle"       : updateTitle,
//                                "updateDescription" : updateDescription
//
//            ]) { (error) in
//                if let error = error {
//                    print("dontation posting error: \(error.localizedDescription)")
//                } else {
//                    print("donations post successufully")
//                }
//        }
        
    }

//        if let textTitle = self.updateTextView.text {
//            if let textTitle1 = self.updateTextField.text {
//            let newUpdate = Update.init(updatesTitle: textTitle1, updates: textTitle)
//        update.append(newUpdate)
//        }
//        }
        
    
    
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
        cell.textLabel?.text = update[indexPath.row].0
        cell.detailTextLabel?.text =  update[indexPath.row].1
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
