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
    
    //var userD = DataPersistenceModel.get()
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
       
        DatabaseManager.firebaseDB.collection("donations").addSnapshotListener { (donation, error) in
            guard let donation1 = donation else
            {return}
            self.userDInfo.removeAll()
    
            for item in donation1.documents {
                self.userDInfo.append(Donate.init(dict: item.data()))
            }
        }
        
        
    }
    
    private func imageForCell(indexPath: IndexPath, completion: @escaping ((UIImage) -> Void))  {
        
        guard let imageURL = userDInfo[indexPath.row].causeImageURL,
            !imageURL.isEmpty else {
                print("no imageURL")
                return
        }
        ImageHelper.fetchImageFromNetwork(urlString: imageURL) { (appError, image) in
            DispatchQueue.main.async {
                
            
            if let appError = appError {
                print(appError)
            } else if let image = image {
                completion(image)
            }
            }
        }
        
    }
    
}
extension UserDonationsViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return  userDInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "DonationCell", for: indexPath) as? DonationsCollectionViewCell else {return UICollectionViewCell()}
        let photoToSet = userDInfo[indexPath.row]
        cell.donationsLabel.text = userDInfo[indexPath.row].causeTitle
        print(photoToSet.causeImageURL)
        ImageHelper.fetchImageFromNetwork(urlString: photoToSet.causeImageURL ?? "") { (error, image) in
            DispatchQueue.main.async {
                if let error = error {
                    print(error)
                }else if let image = image {
                    cell.donationsImageView.image = image
                }
            }
        }
        
//        imageForCell(indexPath: indexPath) { (image) in
//            cell.donationsImageView.image = image
//        }
//        cell.layer.borderColor = UIColor.yellow.cgColor
//        cell.layer.borderWidth = 1
        return cell
            
    }
        
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let userDetail = storyboard.instantiateViewController(withIdentifier: "donationsDetail") as? UserDonationsDetailViewController else {print("NO VC")
            return
        }
    
        let userDInfoToSend = userDInfo[indexPath.row]
        userDetail.create = userDInfoToSend
        userDetail.modalPresentationStyle = .fullScreen
        present(userDetail, animated: true, completion: nil)

    }
    
}


