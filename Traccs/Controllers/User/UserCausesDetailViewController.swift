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

    
    var UCauseInfo: Donate?
    var picture: UIImage?
    
    @IBOutlet weak var UDetailImageView: UIImageView!
    @IBOutlet weak var UDetailLabel: UILabel!
    @IBOutlet weak var UDetailTextView: UITextView!
    @IBOutlet weak var donateTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpPage()

    }
    
    private func setUpPage() {
        self.UDetailLabel.text = UCauseInfo?.causeTitle
        self.UDetailTextView.text = UCauseInfo?.causeDescription
        self.UDetailImageView.image = picture!
        
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    
    @IBAction func donateButtonPressed(_ sender: UIButton) {
        
        guard let causeTitle = UDetailLabel.text,
        let causeDescription = UDetailTextView.text,
        let causeImage = UCauseInfo?.causeImageURL,
        let donationAmount = donateTextField.text,
            !causeTitle.isEmpty, !causeDescription.isEmpty, !donationAmount.isEmpty else {
                return
                
        }
        DatabaseManager.firebaseDB
            .collection("donations")
            .addDocument(data: ["causeTitle"        : causeTitle,
                                "causeDescription"  : causeDescription,
                                "causeImageURL"     : causeImage,
                                "causeId"           : "",
                                "donationAmount"    : donationAmount
            ]) { (error) in
                if let error = error {
                    print("dontation posting error: \(error.localizedDescription)")
                } else {
                    print("donations post successufully")
                }
        }

        
    
}
}
