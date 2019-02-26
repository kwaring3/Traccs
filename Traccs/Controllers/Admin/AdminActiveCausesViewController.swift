//
//  AdminActiveCausesViewController.swift
//  Traccs
//
//  Created by Kevin Waring on 2/14/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import UIKit

class AdminActiveCausesViewController: UIViewController {

    @IBOutlet weak var activeCollectionView: UICollectionView!
    
    var causes = DataPersistenceModel.get()
    var causeInfo = [Create]() {
        didSet{
            activeCollectionView.reloadData()
        }
        
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        activeCollectionView.dataSource = self
        causeInfo = DataPersistenceModel.get()
        
    }
    func reload() {
        causes = DataPersistenceModel.get()
        activeCollectionView.reloadData()
    }
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        guard let indexPath = activeCollectionView.indexPathsForSelectedItems, let destination = segue.destination as? AdminActiveCausesDetailViewController else {fatalError("index path nil")}
//        let result = causeInfo[indexPath]
//        destination.result = result
//    }
    

    

}
extension AdminActiveCausesViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return causeInfo.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ActiveCell", for: indexPath) as? AdminActiveCausesCollectionViewCell else {return UICollectionViewCell()}
        let photoToSet = causes[indexPath.row]
        cell.titleLabel.text = causeInfo[indexPath.row].title
        cell.activeImageView.image = UIImage(data: photoToSet.image)
        cell.backgroundColor = .white
//        cell.button.tag = indexPath.row
//        cell.button.addTarget(self, action: #selector(buttonPressed(sender:)), for: .touchUpInside)
        cell.layer.borderColor = UIColor.black.cgColor
        cell.layer.borderWidth = 1
        return cell
    }
    
    
}
