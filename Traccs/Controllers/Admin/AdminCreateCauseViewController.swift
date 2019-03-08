//
//  AdminCreateCauseViewController.swift
//  Traccs
//
//  Created by Kevin Waring on 2/14/19.
//  Copyright © 2019 Kevin Waring. All rights reserved.
//

import UIKit
import FirebaseFirestore
import FirebaseStorage


class AdminCreateCauseViewController: UIViewController {

    
    var indexNum: Int!
    var imageSelected: UIImage!
    private var usersession: UserSession!
    private var storageManager: StorageManager!
    private var imagePicker: UIImagePickerController!
    
    @IBOutlet weak var createButton: UIButton!
    @IBOutlet weak var createTextView: UITextView!
    @IBOutlet weak var createImageView: UIImageView!
    @IBOutlet weak var createTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        
        // getting instance from AppDelegate
        usersession = (UIApplication.shared.delegate as! AppDelegate).userSession
        storageManager = (UIApplication.shared.delegate as! AppDelegate).storageManager
        
        
        
        storageManager.delegate = self

        
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
        guard let causeImage = createImageView.image?.jpegData(compressionQuality: 0.5) else {return}
        storageManager.postImage(withData: causeImage)
//        guard let causeTitle = createTextView.text,
//            let causeDescription = createTextField.text,
//            let causeImage = createImageView.image?.jpegData(compressionQuality: 0.5),
//
//            !causeTitle.isEmpty, !causeDescription.isEmpty else {
//                return
//
//        }
//        DatabaseManager.firebaseDB
//            .collection("causes")
//            .addDocument(data: ["causeTitle"        : causeTitle,
//                                "causeDescription"  : causeDescription,
//                                "causeImageURL"     : causeImage,
//                                "causeId"           : ""
//
//            ]) { (error) in
//                if let error = error {
//                    print("dontation posting error: \(error.localizedDescription)")
//                } else {
//                    print("donations post successufully")
//                }
//        }

//    if let deleteFile = indexNum {
//        DataPersistenceModel.deleteQuiz(index: deleteFile)
//    }
//        guard let textTitle = self.createTextField.text else {
//    fatalError("nil")}
//    let date = Date()
//    let isoDateFormatter = ISO8601DateFormatter()
//    isoDateFormatter.formatOptions = [.withFullDate, .withFullTime, .withInternetDateTime, .withTimeZone, .withDashSeparatorInDate]
//    let timeStamp = isoDateFormatter.string(from: date)
//
//    if let imageData = createImageView.image?.jpegData(compressionQuality: 0.5){
//        if let text = createTextView.text {
//            let photo = AdminCause.init(image: imageData, title: textTitle, causeDescription: text, createdAt: timeStamp)
//            DataPersistenceModel.add1(cause: photo)
//            dismiss(animated: true, completion: nil)
//        }
//
//
//    } else {
//    dismiss(animated: true, completion: nil)
//    }
}
    private func cancel() {
        dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func createButtonPressed(_ sender: UIButton) {
         save()
        //reset()
        //self.createImageView.image = (UIImage(named: "placeholder-image-2"))
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
extension AdminCreateCauseViewController: StorageManagerDelegate {
    func didFetchImage(_ storageManager: StorageManager, imageURL: URL) {
        usersession.updateUser(displayName: nil, photoURL: imageURL)
        guard let causeTitle = createTextField.text,
            let causeDescription = createTextView.text,
            
            
            !causeTitle.isEmpty, !causeDescription.isEmpty else {
                return
                
        }
        DatabaseManager.firebaseDB
            .collection("causes")
            .addDocument(data: ["causeTitle"        : causeTitle,
                                "causeDescription"  : causeDescription,
                                "causeImageURL"     : imageURL.absoluteString,
                                "causeId"           : ""
                
            ]) { (error) in
                if let error = error {
                    print("dontation posting error: \(error.localizedDescription)")
                } else {
                    print("donations post successufully")
                }
        }
        //reset()
    }
}

    
    


