//
//  ProfilePresenter.swift
//  Submission1GameApp
//
//  Created by izzudin on 21/11/20.
//  Copyright © 2020 izzudin. All rights reserved.
//

import Foundation

public protocol ProfileContractView {
    func onGetname(name: String)
    func onGetEmail(email: String)
    func onGetProfession(profession: String)
    func onGetCertificate(certificate: String)
    func onGetPhotoProfile(photo: Data?)
}

public class ProfilePresenter {
    
    private let useCase: ProfileUseCase
    var listener: ProfileContractView?
    
    public init(useCase: ProfileUseCase) {
        self.useCase = useCase
    }
    
    func getName() {
        listener?.onGetname(name: useCase.getName())
    }
    
    func getEmail() {
        listener?.onGetEmail(email: useCase.getEmail())
    }
    
    func getProfession() {
        listener?.onGetProfession(profession: useCase.getProfession())
    }
    
    func getCertificate() {
        listener?.onGetCertificate(certificate: useCase.getCertificate())
    }
    
    func getPhotoProfile() {
        listener?.onGetPhotoProfile(photo: useCase.getPhotoProfile())
    }
}
