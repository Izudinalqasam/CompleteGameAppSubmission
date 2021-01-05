//
//  EditProfileViewViewController.swift
//  Submission1GameApp
//
//  Created by izzudin on 16/10/20.
//  Copyright © 2020 izzudin. All rights reserved.
//

import UIKit

public class EditProfileViewViewController: UIViewController {
    
    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var professionTextField: UITextField!
    @IBOutlet weak var saveButton: UIButton!
    @IBOutlet weak var certificateTextField: UITextField!
    
    private let imagePicker = UIImagePickerController()
    private let activityIndicator = UIActivityIndicatorView()
    public var presenter: EditProfilePresenter?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.listener = self
        
        imagePicker.delegate = self
        imagePicker.allowsEditing = true
        imagePicker.sourceType = .photoLibrary
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        view.addSubview(activityIndicator)
        
        setupInitialData()
    }
    
    private func setupInitialData() {
        presenter?.getName()
        presenter?.getEmail()
        presenter?.getProfession()
        presenter?.getCertificate()
        presenter?.getPhotoProfile()
    }
    
    @IBAction func getImage(_ sender: Any) {
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func saveProfile(_ sender: Any) {
        activityIndicator.startAnimating()
        if let name = nameTextField.text, !name.isEmpty {
            presenter?.setName(name: name)
        }
        
        if let email = emailTextField.text, !email.isEmpty {
            presenter?.setEmail(email: email)
        }
        
        if let profession = professionTextField.text, !profession.isEmpty {
            presenter?.setProfession(profession: profession)
        }
        
        if let certificate = certificateTextField.text, !certificate.isEmpty {
            presenter?.setCertificate(certificate: certificate)
        }
        
        if let image = profileImage.image?.pngData() {
            presenter?.setPhotoProfile(photo: image)
        }
        
        activityIndicator.stopAnimating()
        navigationController?.popViewController(animated: true)
    }
    
    func alert(_ message: String) {
        let alertController = UIAlertController(title: "Warning", message: message, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
}

extension EditProfileViewViewController: EditProfileContractView {
    public func onGettingName(name: String) {
        nameTextField.text = name
    }
    
    public func onGettingEmail(email: String) {
        emailTextField.text = email
    }
    
    public func onGettingProfession(profession: String) {
        professionTextField.text = profession
    }
    
    public func onGettingCertificate(certificate: String) {
        certificateTextField.text = certificate
    }
    
    public func onGettingPhotoProfile(photo: Data?) {
        if let photo = photo {
            profileImage.image = UIImage(data: photo)
        } else {
            profileImage.image = UIImage(named: "pp")
        }
        
        profileImage.contentMode = UIView.ContentMode.scaleAspectFill
        profileImage.layer.cornerRadius = profileImage.frame.height / 2
        profileImage.layer.masksToBounds = false
        profileImage.clipsToBounds = true
    }
        
}

extension EditProfileViewViewController: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        if let result = info[UIImagePickerController.InfoKey.editedImage] as? UIImage {
            self.profileImage.contentMode = .scaleToFill
            self.profileImage.image = result
            dismiss(animated: true, completion: nil)
        } else {
            let alertError = UIAlertController(title: "Failed", message: "Image can't be loaded", preferredStyle: .alert)
            alertError.addAction(UIAlertAction(title: "Dismiss", style: .cancel, handler: nil))
            self.present(alertError, animated: true, completion: nil)
        }
    }
}
