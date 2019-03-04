//
//  UserDonationsViewController.swift
//  Traccs
//
//  Created by Kevin Waring on 2/14/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import UIKit

class UserDonationsViewController: UIViewController {

    @IBOutlet weak var userDCollectionView: UICollectionView!
    
    var userD = DataPersistenceModel.get()
    var userDInfo = [Donate]() {
        didSet{
            DispatchQueue.main.async {
                self.userDCollectionView.reloadData()
            }
            
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        userDCollectionView.dataSource = self
        userDCollectionView.delegate = self
        
    }
    

    

}
extension UserDonationsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  1 // userDInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DonationCell", for: indexPath) as? DonationsCollectionViewCell else {return UICollectionViewCell()}
        let photoToSet = userD[indexPath.row]
        //cell.donationsLabel.text = userDInfo[indexPath.row].name
        cell.donationsImageView.image = UIImage(data: photoToSet.image)
        cell.backgroundColor = .white
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let userDetail = storyboard.instantiateViewController(withIdentifier: "donationsDetail") as? UserDonationsDetailViewController else {print("NO VC")
            return
        }
        let userDInfoToSend = userD[indexPath.row]
        userDetail.create = userDInfoToSend
        userDetail.modalPresentationStyle = .fullScreen
        present(userDetail, animated: true, completion: nil)

    }
    
}
