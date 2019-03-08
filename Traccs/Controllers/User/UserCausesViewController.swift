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
    
    //var UCauses = DataPersistenceModel.get()
    var UCauseInfo = [AdminCause]() {
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
        DatabaseManager.firebaseDB.collection("causes").getDocuments { (data, error) in
            guard let cause1 = data else {return}
            
            for item in cause1.documents {
                self.UCauseInfo.append(AdminCause.init(dict: item.data()))
            }
        }
        
    }
    func reload() {
        UCauseInfo = DataPersistenceModel.get()
        userCauseCollectionView.reloadData()
    }
    

    
}
extension UserCausesViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return UCauseInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "userCauseCell", for: indexPath) as? UserCausesCollectionViewCell else {return UICollectionViewCell()}
        let photoToSet = UCauseInfo[indexPath.row]
        cell.userCausesLabel.text = UCauseInfo[indexPath.row].title
        ImageHelper.fetchImageFromNetwork(urlString:photoToSet.image.absoluteString ?? "") { (error, image) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                }else if let image = image {
                    cell.userCausesImage.image = image
                }
            }
        }
        //cell.userCausesImage.image = UIImage(data: photoToSet.image)
        //cell.backgroundColor = .white
        //        cell.button.tag = indexPath.row
        //        cell.button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
//        cell.layer.borderColor = UIColor.black.cgColor
//        cell.layer.borderWidth = 1
        return cell
}
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let userCausesDetail = storyboard.instantiateViewController(withIdentifier: "userCausesDetailViewController") as? UserCausesDetailViewController else {print("NO VC")
            return
        }
       // guard let selectedCell = collectionView.cellForItem(at: indexPath) as? UserCausesCollectionViewCell else {return}

        let UCauseInfoToSend = UCauseInfo[indexPath.row]
        userCausesDetail.Ucauses = UCauseInfoToSend
        userCausesDetail.modalPresentationStyle = .fullScreen
        present(userCausesDetail, animated: true, completion: nil)
        
    }
}
