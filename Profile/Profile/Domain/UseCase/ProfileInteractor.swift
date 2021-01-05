//
//  ProfileInteractor.swift
//  Submission1GameApp
//
//  Created by izzudin on 22/11/20.
//  Copyright © 2020 izzudin. All rights reserved.
//

import Foundation

public protocol ProfileUseCase {
    func getName() -> String
    func getEmail() -> String
    func getProfession() -> String
    func getCertificate() -> String
    func getPhotoProfile() -> Data?
    
    func setName(name: String)
    func setEmail(email: String)
    func setProfession(profession: String)
    func setCertificate(certificate: String)
    func setPhotoProfile(photo: Data)
}

public class ProfileInteractor: ProfileUseCase {
    
    private let repository: ProfileRepositoryProtocol
    
    public required init(repository: ProfileRepositoryProtocol) {
        self.repository = repository
    }
    
    public func setName(name: String) {
        repository.setName(name: name)
    }
    
    public func setEmail(email: String) {
        repository.setEmail(email: email)
    }
    
    public func setProfession(profession: String) {
        repository.setProfession(profession: profession)
    }
    
    public func setCertificate(certificate: String) {
        repository.setCertificate(certificate: certificate)
    }
    
    public func setPhotoProfile(photo: Data) {
        repository.setPhotoProfile(photo: photo)
    }
    
    public func getName() -> String {
        return repository.getName()
    }
    
    public func getEmail() -> String {
        return repository.getEmail()
    }
    
    public func getProfession() -> String {
        return repository.getProfession()
    }
    
    public func getCertificate() -> String {
        return repository.getCertificate()
    }
    
    public func getPhotoProfile() -> Data? {
        return repository.getPhotoProfile()
    }
}
