//
//  File.swift
//  Submission1GameApp
//
//  Created by izzudin on 17/10/20.
//  Copyright © 2020 izzudin. All rights reserved.
//

import Foundation
import CoreData
import RxSwift

public class FavoriteProvider {
    private let idAttribute = "idGame"
    private let nameAttribute = "name"
    private let ratingAttribute = "rating"
    private let releaseAttribute = "released"
    private let descriptionAttribute = "descriptions"
    private let backgroundAttribute = "backgroundImage"
    private let favoriteModel = "GameFavorite"
    private let favoriteEntiry = "Favorite"
    
    public init() {}
    
    lazy var persistentContainer: NSPersistentContainer = {
        let container: NSPersistentContainer = {
            let bundle = Bundle(identifier: "com.izudin.swift.Games")
            let modelUrl = bundle?.url(forResource: "GameFavorite", withExtension: "momd")
            let managedObjectModel = NSManagedObjectModel(contentsOf: modelUrl!)!
            
            return NSPersistentContainer(name: "GameFavorite", managedObjectModel: managedObjectModel)
        }()
        
        container.loadPersistentStores { (_, error) in
            if error != nil, let error = error {
                fatalError("Unresolved error \(error)")
            }
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
        container.viewContext.mergePolicy = NSMergeByPropertyObjectTrumpMergePolicy
        container.viewContext.shouldDeleteInaccessibleFaults = true
        container.viewContext.undoManager = nil
        
        return container
    }()
    
    private func newTaskContext() -> NSManagedObjectContext {
        let taskContext = persistentContainer.newBackgroundContext()
        taskContext.undoManager = nil
        
        taskContext.mergePolicy = NSMergeByPropertyStoreTrumpMergePolicy
        return taskContext
    }
    
    public func createGameFavorite(gameFavorite: GameItemDetailEntity) -> Completable {
        return Completable.create { (observer) -> Disposable in
            let taskContext = self.newTaskContext()
            
            taskContext.performAndWait {
                if let entity = NSEntityDescription.entity(forEntityName: self.favoriteEntiry, in: taskContext) {
                    let game = NSManagedObject(entity: entity, insertInto: taskContext)
                    game.setValue(gameFavorite.idGame, forKeyPath: self.idAttribute)
                    game.setValue(gameFavorite.name, forKey: self.nameAttribute)
                    game.setValue(gameFavorite.released, forKey: self.releaseAttribute)
                    game.setValue(gameFavorite.rating, forKey: self.ratingAttribute)
                    game.setValue(gameFavorite.backgroundImage, forKey: self.backgroundAttribute)
                    game.setValue(gameFavorite.description, forKey: self.descriptionAttribute)
                    
                    do {
                        try taskContext.save()
                        observer(.completed)
                    } catch let error as NSError {
                        print("Could not save. \(error), \(error.userInfo)")
                        observer(.error(error))
                    }
                }
            }
            
            return Disposables.create()
        }
    }
    
    public func getAllGameFavorites() -> Observable<[GameItemDetailEntity]> {
        return Observable.create { (observer) -> Disposable in
            
            let taskContext = self.newTaskContext()
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.favoriteEntiry)
                do {
                    let results = try taskContext.fetch(fetchRequest)
                    var games: [GameItemDetailEntity] = []
                    
                    for result in results {
                        let game = GameItemDetailEntity(
                            idGame: (result.value(forKeyPath: self.idAttribute) as? Int) ?? 0,
                            name: (result.value(forKeyPath: self.nameAttribute) as? String) ?? "",
                            released: (result.value(forKeyPath: self.releaseAttribute) as? String) ?? "",
                            rating: (result.value(forKeyPath: self.ratingAttribute) as? Float) ?? 0.0,
                            backgroundImage: (result.value(forKeyPath: self.backgroundAttribute) as? String) ?? "",
                            description: (result.value(forKeyPath: self.descriptionAttribute) as? String) ?? "")
                    
                        games.append(game)
                    }
                    
                    observer.onNext(games)
                    observer.onCompleted()
                } catch let error as NSError {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    public func getGameFavorite(idGame: String) -> Observable<GameItemDetailEntity> {
        return Observable.create { (observer) -> Disposable in
            
            let taskContext = self.newTaskContext()
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: self.favoriteEntiry)
                fetchRequest.fetchLimit = 1
                fetchRequest.predicate = NSPredicate(format: "idGame == \(idGame)")

                do {
                    if let result = try taskContext.fetch(fetchRequest).first {
                        let game = GameItemDetailEntity(
                            idGame: (result.value(forKeyPath: self.idAttribute) as? Int) ?? 0,
                            name: (result.value(forKeyPath: self.nameAttribute) as? String) ?? "",
                            released: (result.value(forKeyPath: self.releaseAttribute) as? String) ?? "",
                            rating: (result.value(forKeyPath: self.ratingAttribute) as? Float) ?? 0.0,
                            backgroundImage: (result.value(forKeyPath: self.backgroundAttribute) as? String) ?? "",
                            description: (result.value(forKeyPath: self.descriptionAttribute) as? String) ?? ""
                        )
                    
                        observer.onNext(game)
                        observer.onCompleted()
                    }
                } catch let error as NSError {
                    observer.onError(error)
                }
            }
            
            return Disposables.create()
        }
    }
    
    public func deleteGameFavorite(idGame: Int) -> Completable {
        return Completable.create { (observer) -> Disposable in
            let taskContext = self.newTaskContext()
            taskContext.perform {
                let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: self.favoriteEntiry)
                fetchRequest.fetchLimit = 1
                fetchRequest.predicate = NSPredicate(format: "idGame == \(idGame)")
                
                let batchDeleteRequest = NSBatchDeleteRequest(fetchRequest: fetchRequest)
                batchDeleteRequest.resultType = .resultTypeCount
                
                if let batchDeleteResult = try? taskContext.execute(batchDeleteRequest) as? NSBatchDeleteResult, batchDeleteResult.result != nil {
                    observer(.completed)
                }
            }
            
            return Disposables.create()
        }
    }
}
