//
//  UserCausesViewController.swift
//  Traccs
//
//  Created by Kevin Waring on 2/14/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import UIKit

class UserCausesViewController: UIViewController {

    @IBOutlet weak var userCauseCollectionView: UICollectionView!
    
    var UCauses = DataPersistenceModel.get()
    var UCauseInfo = [Create]() {
        didSet{
            DispatchQueue.main.async {
                self.userCauseCollectionView.reloadData()
            }
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        userCauseCollectionView.dataSource = self
        userCauseCollectionView.delegate = self
        UCauseInfo = DataPersistenceModel.get()
        
    }
    func reload() {
        UCauses = DataPersistenceModel.get()
        userCauseCollectionView.reloadData()
    }
    

    
}
extension UserCausesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UCauseInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCauseCell", for: indexPath) as? UserCausesCollectionViewCell else {return UICollectionViewCell()}
        let photoToSet = UCauses[indexPath.row]
        cell.userCausesLabel.text = UCauseInfo[indexPath.row].title
        cell.userCausesImage.image = UIImage(data: photoToSet.image)
        cell.backgroundColor = .white
        //        cell.button.tag = indexPath.row
        //        cell.button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        return cell
}
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let userCausesDetail = storyboard.instantiateViewController(withIdentifier: "userCausesDetailViewController") as? UserCausesDetailViewController else {print("NO VC")
            return
        }
        let UCauseInfoToSend = UCauses[indexPath.row]
        userCausesDetail.UCauseInfo = UCauseInfoToSend
        userCausesDetail.modalPresentationStyle = .fullScreen
        present(userCausesDetail, animated: true, completion: nil)
        
    }
}
