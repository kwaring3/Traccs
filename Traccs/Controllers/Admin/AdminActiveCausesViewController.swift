//
//  AdminActiveCausesViewController.swift
//  Traccs
//
//  Created by Kevin Waring on 2/14/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import UIKit
import FirebaseFirestore

class AdminActiveCausesViewController: UIViewController {

    @IBOutlet weak var activeCollectionView: UICollectionView!
    
    //var causes = DataPersistenceModel.get()
    var causeInfo = [AdminCause]() {
        didSet{
            DispatchQueue.main.async {
                self.activeCollectionView.reloadData()
            }
            
        }
        
    }
    var listener: ListenerRegistration!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activeCollectionView.dataSource = self
        activeCollectionView.delegate = self
       // causeInfo = DataPersistenceModel.get()
        DatabaseManager.firebaseDB.collection("causes").getDocuments { (data, error) in
            guard let cause1 = data else {return}
            
            //self.causeInfo.removeAll()
            
            for item in cause1.documents {
                self.causeInfo.append(AdminCause.init(dict: item.data()))
        }
            self.causeInfo.sort(by: { (firstCause, secondCause) -> Bool in
                let format = ISO8601DateFormatter()
                guard let firstDate = format.date(from: firstCause.createdAt),
                let secondDate = format.date(from: secondCause.createdAt) else {return false}
                return firstDate > secondDate 
            })
        }
        
    }
    override func viewWillAppear(_ animated: Bool) {
       // loadPage()
        
    }
    override func viewDidAppear(_ animated: Bool) {
        //reload()
    }
    func loadPage() {
        DatabaseManager.firebaseDB.collection("causes").getDocuments { (data, error) in
            guard let cause1 = data else {return}
            
            for item in cause1.documents {
                self.causeInfo.append(AdminCause.init(dict: item.data()))
            }
        }
    }
//    func reload() {
//        causeInfo = DataPersistenceModel.get()
//        activeCollectionView.reloadData()
//    }
    
    
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let indexPath = activeCollectionView.indexpath  let destination = segue.destination as? AdminActiveCausesDetailViewController else {fatalError("index path nil")}
//        let cause = causeInfo[indexPath]
//        destination.create = cause
//    }
    
    @IBAction func activeCauseButtonPressed(_ sender: UIButton) {
        let index = sender.tag
        let actionSheet = UIAlertController.init(title: nil, message: nil, preferredStyle: .actionSheet)
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert: UIAlertAction!) -> Void in
        }
        let delete = UIAlertAction(title: "Delete", style: .destructive) { (UIAlertAction) in
            DataPersistenceModel.deleteQuiz(index: index)
            //self.reload()
            
            
//            self.causes = DataPersistenceModel.get()
//            self.activeCollectionView.reloadData()
            
        }
        actionSheet.addAction(cancelAction)
        actionSheet.addAction(delete)
        self.present(actionSheet, animated: true, completion: nil)
    }
    
    

}
extension AdminActiveCausesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return causeInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActiveCell", for: indexPath) as? AdminActiveCausesCollectionViewCell else {return UICollectionViewCell()}
        let photoToSet = causeInfo[indexPath.row]
        cell.titleLabel.text = photoToSet.title
        ImageHelper.fetchImageFromNetwork(urlString:photoToSet.image.absoluteString ) { (error, image) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                }else if let image = image {
                    cell.activeImageView.image = image
                }
            }
        }
        //cell.activeImageView.image = UIImage(data: photoToSet.image)
        //cell.layer.borderColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        //cell.layer.borderWidth = 1
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let adminActiveDetail = storyboard.instantiateViewController(withIdentifier: "adminActiveDetail") as? AdminActiveCausesDetailViewController else {print("NO VC")
            return
        }
        let causeInfoToSend = causeInfo[indexPath.row]
        adminActiveDetail.causeInfo = causeInfoToSend
        adminActiveDetail.modalPresentationStyle = .fullScreen
        present(adminActiveDetail, animated: true, completion: nil)
        
    }
    
}
