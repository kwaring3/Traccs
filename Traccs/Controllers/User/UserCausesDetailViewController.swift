//
//  UserCausesDetailViewController.swift
//  Traccs
//
//  Created by Kevin Waring on 2/14/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import UIKit
import FirebaseFirestore

class UserCausesDetailViewController: UIViewController {

    
    var UCauseInfo: AdminCause?
    
    @IBOutlet weak var UDetailImageView: UIImageView!
    @IBOutlet weak var UDetailLabel: UILabel!
    @IBOutlet weak var UDetailTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPage()

    }
    
    private func setUpPage() {
        self.UDetailLabel.text = UCauseInfo?.title
        self.UDetailTextView.text = UCauseInfo?.causeDescription
        self.UDetailImageView.image = (UIImage(data:(UCauseInfo?.image)! ))
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func donateButtonPressed(_ sender: UIButton) {

        
        // cause description
        // cause title
        //cause image
        // donationAmount
        
        guard let causeTitle = UDetailLabel.text,
        let causeDescription = UDetailTextView.text,
        let causeImage = UDetailImageView.image,
            !causeTitle.isEmpty, !causeDescription.isEmpty else {
                return
                
        }
        
        //DatabaseManager.firebaseDB
          //  .collection("")

        
        //        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
//        guard let userDonated = storyboard.instantiateViewController(withIdentifier: "UserDonatedViewController") as? UserDonatedViewController else {print("NO VC")
//            return
//        }
//
//        userDonated.modalPresentationStyle = .fullScreen
//        present(userDonated, animated: true, completion: nil)
//    }
    
//    @IBAction func metricsButtonPressed(_ sender: UIButton) {
//        let alert = UIAlertController(title: "Donations Breakdown", message: "                                                                           ____________________________________________________________________________       ", preferredStyle: .alert)
//
//
//        let imageView = UIImageView(frame: CGRect(x: 120, y: 50, width: 40, height: 40))
//        imageView.image = UIImage(named: "placeholder-image-2")
//
//        alert.view.addSubview(imageView)
//        alert.view.addSubview(imageView)
//        alert.addAction(UIAlertAction(title: "OK", style: .default))
//        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel) { (alert: UIAlertAction!) -> Void in
//
//        }
//
//        alert.addAction(cancelAction)
//        self.present(alert, animated: true, completion: nil)
//    }
    
}
}
