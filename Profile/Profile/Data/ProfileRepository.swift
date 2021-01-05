//
//  ProfileRepository.swift
//  Profile
//
//  Created by izzudin on 04/01/21.
//

import Foundation

public protocol ProfileRepositoryProtocol {
    func setName(name: String)
    func getName() -> String
    func setEmail(email: String)
    func getEmail() -> String
    func setProfession(profession: String)
    func getProfession() -> String
    func setCertificate(certificate: String)
    func getCertificate() -> String
    func setPhotoProfile(photo: Data)
    func getPhotoProfile() -> Data?
}

public struct ProfileRepository: ProfileRepositoryProtocol {
    
    private var local: ProfileLocaleDataSource
    
    public init(local: ProfileLocaleDataSource) {
        self.local = local
    }
    
    public func setName(name: String) {
        local.name = name
    }
    
    public func getName() -> String {
        return local.name
    }
    
    public func setEmail(email: String) {
        local.email = email
    }
    
    public func getEmail() -> String {
        return local.email
    }
    
    public func setProfession(profession: String) {
        local.profession = profession
    }
    
    public func getProfession() -> String {
        return local.profession
    }
    
    public func setCertificate(certificate: String) {
        local.certificate = certificate
    }
    
    public func getCertificate() -> String {
        return local.certificate
    }
    
    public func setPhotoProfile(photo: Data) {
        local.photo = photo
    }
    
    public func getPhotoProfile() -> Data? {
        return local.photo
    }
}
