//
//  ProfileViewController.swift
//  Submission1GameApp
//
//  Created by izzudin on 18/10/20.
//  Copyright © 2020 izzudin. All rights reserved.
//

import UIKit

public class ProfileViewController: UIViewController {

    @IBOutlet weak var photoProfile: UIImageView!
    @IBOutlet weak var nameProfile: UILabel!
    @IBOutlet weak var professionProfile: UILabel!
    @IBOutlet weak var certificateProfile: UILabel!
    @IBOutlet weak var emailProfile: UILabel!
    
    public var presenter: ProfilePresenter?
    
    public override func viewWillAppear(_ animated: Bool) {
        presenter?.listener = self
        presenter?.getName()
        presenter?.getEmail()
        presenter?.getProfession()
        presenter?.getCertificate()
        presenter?.getPhotoProfile()
    }
}

extension ProfileViewController: ProfileContractView {
    public func onGetname(name: String) {
        nameProfile.text = name
    }
    
    public func onGetEmail(email: String) {
        emailProfile.text = email
    }
    
    public func onGetProfession(profession: String) {
        professionProfile.text = profession
    }
    
    public func onGetCertificate(certificate: String) {
        certificateProfile.text = certificate.replacingOccurrences(of: ",", with: "\n")
    }
    
    public func onGetPhotoProfile(photo: Data?) {
        if let image = photo {
            photoProfile.image = UIImage(data: image)
        } else {
            photoProfile.image = UIImage(named: "pp")
        }
    }
}
