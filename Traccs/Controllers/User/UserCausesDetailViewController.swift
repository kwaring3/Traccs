//
//  UserCausesDetailViewController.swift
//  Traccs
//
//  Created by Kevin Waring on 2/14/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import UIKit

class UserCausesDetailViewController: UIViewController {

    
    var UCauseInfo: Create?
    
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
        let storyboard = UIStoryboard.init(name: "Main", bundle: nil)
        guard let userDonated = storyboard.instantiateViewController(withIdentifier: "UserDonatedViewController") as? UserDonatedViewController else {print("NO VC")
            return
        }

        userDonated.modalPresentationStyle = .fullScreen
        present(userDonated, animated: true, completion: nil)
    }
    

}
