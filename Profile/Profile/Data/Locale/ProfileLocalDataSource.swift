//
//  ProfileLocalDataSource.swift
//  Profile
//
//  Created by izzudin on 04/01/21.
//

import Foundation

public class ProfileLocaleDataSource {
    private let userDefault: UserDefaults
    
    private let nameKey = "name_key"
    private let emailKey = "email_key"
    private let professionKey = "profession_key"
    private let certificateKey =  "certificate_key"
    private let photoProfileKey = "photo_key"
    
    public init(userDefault: UserDefaults) {
        self.userDefault = userDefault
    }
    
    public var name: String {
        get {
            return userDefault.string(forKey: nameKey) ?? "Muhammmad Izzuddin Al Qassam"
        }
        set {
            userDefault.set(newValue, forKey: nameKey)
        }
    }
    
    public var email: String {
        get {
            return userDefault.string(forKey: emailKey)
            ?? "ibrohim.gariskeras@gmail.com"
        }
        set {
            userDefault.set(newValue, forKey: emailKey)
        }
    }
    
    public var profession: String {
        get {
            return userDefault.string(forKey: professionKey) ?? "Software Engineer Mobile"
        }
        set {
            userDefault.set(newValue, forKey: professionKey)
        }
    }
    
    public var certificate: String {
        get {
            return userDefault.string(forKey: certificateKey)
            ?? "Menjadi IOS Developer Expert"
        }
        set {
            userDefault.set(newValue, forKey: certificateKey)
        }
    }
    
    public var photo: Data? {
        get {
            return userDefault.data(forKey: photoProfileKey)
        }
        set {
            userDefault.set(newValue, forKey: photoProfileKey)
        }
    }
}
