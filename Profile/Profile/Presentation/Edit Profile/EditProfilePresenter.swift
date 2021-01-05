//
//  EditProfilePresenter.swift
//  Submission1GameApp
//
//  Created by izzudin on 24/11/20.
//  Copyright © 2020 izzudin. All rights reserved.
//

import Foundation

public protocol EditProfileContractView {
    func onGettingName(name: String)
    func onGettingEmail(email: String)
    func onGettingProfession(profession: String)
    func onGettingCertificate(certificate: String)
    func onGettingPhotoProfile(photo: Data?)
}

public class EditProfilePresenter {
    
    private let useCase: ProfileUseCase
    var listener: EditProfileContractView?
    
    public init(useCase: ProfileUseCase) {
        self.useCase = useCase
    }
    
    func getName() {
        listener?.onGettingName(name: useCase.getName())
    }
    
    func getEmail() {
        listener?.onGettingEmail(email: useCase.getEmail())
    }
    
    func getProfession() {
        listener?.onGettingProfession(profession: useCase.getProfession())
    }
    
    func getCertificate() {
        listener?.onGettingCertificate(certificate: useCase.getCertificate())
    }
    
    func getPhotoProfile() {
        listener?.onGettingPhotoProfile(photo: useCase.getPhotoProfile())
    }
    
    func setName(name: String) {
        useCase.setName(name: name)
    }
    
    func setEmail(email: String) {
        useCase.setEmail(email: email)
    }
    
    func setProfession(profession: String) {
        useCase.setProfession(profession: profession)
    }
    
    func setCertificate(certificate: String) {
        useCase.setCertificate(certificate: certificate)
    }
    
    func setPhotoProfile(photo: Data) {
        useCase.setPhotoProfile(photo: photo)
    }
}
