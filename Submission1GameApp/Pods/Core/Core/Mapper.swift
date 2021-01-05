//
//  Mapper.swift
//  Core
//
//  Created by izzudin on 04/01/21.
//

import Foundation

public protocol Mapper {
    associatedtype Response
    associatedtype Entity
    associatedtype Domain
    
    func transformResponseToEntity(response: Response) -> Entity
    func transformResponseToDomain(response: Response) -> Domain
    func transformEntityToDomain(entity: Entity) -> Domain
    func transformDomainToEntity(domain: Domain) -> Entity
}
