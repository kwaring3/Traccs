//
//  AdminCreateCauseViewController.swift
//  Traccs
//
//  Created by Kevin Waring on 2/14/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import UIKit

class AdminCreateCauseViewController: UIViewController {

    
    var indexNum: Int!
    var imageSelected: UIImage!
    private var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var createTextView: UITextView!
    @IBOutlet weak var createImageView: UIImageView!
    @IBOutlet weak var createTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self

        
    }
    override func viewDidAppear(_ animated: Bool) {
        reset()
    }
    private func showImagePickerController() {
        present(imagePicker, animated: true, completion: nil)
    }
    
    private func reset() {
        createTextField.text = nil
        self.createTextField.placeholder = "Enter Name of Cause"
        self.createTextView.text = "Enter Description of Cause"
        
    }
    private func save() {
    if let deleteFile = indexNum {
        DataPersistenceModel.deleteQuiz(index: deleteFile)
    }
        guard let textTitle = self.createTextField.text else {
    fatalError("nil")}
    let date = Date()
    let isoDateFormatter = ISO8601DateFormatter()
    isoDateFormatter.formatOptions = [.withFullDate, .withFullTime, .withInternetDateTime, .withTimeZone, .withDashSeparatorInDate]
    let timeStamp = isoDateFormatter.string(from: date)
    
    if let imageData = createImageView.image?.jpegData(compressionQuality: 0.5){
        if let text = createTextView.text {
            let photo = AdminCause.init(image: imageData, title: textTitle, causeDescription: text, createdAt: timeStamp)
            DataPersistenceModel.add1(cause: photo)
            dismiss(animated: true, completion: nil)
        }

        
    } else {
    dismiss(animated: true, completion: nil)
    }
}
    private func cancel() {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
         save()
        reset()
        self.createImageView.image = (UIImage(named: "placeholder-image-2"))
    }
    @IBAction func imageButtonPressed(_ sender: UIButton) {
        imagePicker.sourceType = .photoLibrary
        showImagePickerController()
    }
}
extension AdminCreateCauseViewController:
UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            createImageView.image = image
            print(image)
            
        } else {
            print("nil")
        }
        dismiss(animated: true, completion: nil)
        
    }
    
}

    
    


