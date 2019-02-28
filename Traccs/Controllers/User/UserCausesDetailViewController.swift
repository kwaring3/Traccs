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

        self.UDetailLabel.text = UCauseInfo?.title
        self.UDetailTextView.text = UCauseInfo?.causeDescription
    }
    
    @IBAction func cancelButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }

    
    

}
