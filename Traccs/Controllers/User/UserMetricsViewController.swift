//
//  UserMetricsViewController.swift
//  Traccs
//
//  Created by Kevin Waring on 3/5/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import UIKit

class UserMetricsViewController: UIViewController {

    @IBOutlet weak var metricsImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func backButtonPressed(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
}
