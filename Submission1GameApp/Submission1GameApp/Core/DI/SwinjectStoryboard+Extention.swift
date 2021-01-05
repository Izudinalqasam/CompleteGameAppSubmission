//
//  SwinjectStoryboard+Extention.swift
//  Submission1GameApp
//
//  Created by izzudin on 15/11/20.
//  Copyright © 2020 izzudin. All rights reserved.
//

import Foundation
import Swinject
import SwinjectStoryboard
import Games
import Core
import Profile
import Favorite

extension SwinjectStoryboard {
    @objc class func setup() {
        // MARK: Mapper
        defaultContainer.register(GamesTransformer.self) { _ in
            GamesTransformer()
        }
        defaultContainer.register(GamesDetailTransformer.self) { _ in
            GamesDetailTransformer()
        }
        defaultContainer.register(FavoriteTransformer.self) { _ in
            FavoriteTransformer()
        }
        
        // Local Data Source
        defaultContainer.register(FavoriteProvider.self) { _ in
            FavoriteProvider()
        }
        defaultContainer.register(GamesLocalDataSource.self) { resolver in
            GamesLocalDataSource(dataSource: resolver.resolve(FavoriteProvider.self) ?? FavoriteProvider())
        }
        defaultContainer.register(ProfileLocaleDataSource.self) { _ in
            ProfileLocaleDataSource(userDefault: UserDefaults.standard)
        }
        defaultContainer.register(FavoriteLocalDataSource.self) { resolver in
            FavoriteLocalDataSource(dataSource: resolver.resolve(FavoriteProvider.self)!)
        }
        
        // MARK: Remote DataSource
        defaultContainer.register(RemoteDataSource.self) { _ in
            RemoteDataSource()
        }
        
        // MARK: Repository
        defaultContainer.register(GamesRepository.self) { resolver in
            GamesRepository(
                local: resolver.resolve(GamesLocalDataSource.self)!,
                remote: resolver.resolve(RemoteDataSource.self)!,
                mapper: resolver.resolve(GamesTransformer.self)!,
                secondMapper: resolver.resolve(GamesDetailTransformer.self)!)
        }
        defaultContainer.register(ProfileRepository.self) { resolver in
            ProfileRepository(local: resolver.resolve(ProfileLocaleDataSource.self)!)
        }
        defaultContainer.register(FavoriteRepository.self) { resolver in
            FavoriteRepository(local: resolver.resolve(FavoriteLocalDataSource.self)!, mapper: resolver.resolve(FavoriteTransformer.self)!)
        }
        
        // MARK: Interactor
        defaultContainer.register(GameInteractor.self) { resolver in
            GameInteractor(repository: resolver.resolve(GamesRepository<GamesLocalDataSource, GamesTransformer, GamesDetailTransformer>.self)!)
        }
        defaultContainer.register(ProfileInteractor.self) { resolver in
            ProfileInteractor(repository: resolver.resolve(ProfileRepository.self)!)
        }
        defaultContainer.register(Interactor.self) { resolver in
            Interactor(repository: resolver.resolve(FavoriteRepository<FavoriteLocalDataSource, FavoriteTransformer>.self)!)
        }
        
        // MARK: Presenter
        defaultContainer.register(HomePresenter.self) { resolver in
            HomePresenter(useCase: resolver.resolve(GameInteractor.self)!)
        }
        defaultContainer.register(ProfilePresenter.self) { resolver in
            ProfilePresenter(useCase: resolver.resolve(ProfileInteractor.self)!)
        }
        defaultContainer.register(GameDetailPresenter.self) { resolver in
            GameDetailPresenter(useCase: resolver.resolve(GameInteractor.self)!)
        }
        defaultContainer.register(
            GetListPresenter<
                String, [GameItemDetail],
                Interactor<String, [GameItemDetail],
                           FavoriteRepository<FavoriteLocalDataSource, FavoriteTransformer>>, GameFavoriteViewController>.self) { resolver in
            GetListPresenter(useCase: resolver.resolve(Interactor.self)!)
        }
        defaultContainer.register(EditProfilePresenter.self) { resolver in
            EditProfilePresenter(useCase: resolver.resolve(ProfileInteractor.self)!)
        }
        
        // MARK: View Controller
        defaultContainer.storyboardInitCompleted(HomeViewController.self) { (resolver, controller) in
            controller.presenter = resolver.resolve(HomePresenter.self)
        }
        defaultContainer.storyboardInitCompleted(ProfileViewController.self) { (resolver, controller) in
            controller.presenter = resolver.resolve(ProfilePresenter.self)
        }
        defaultContainer.storyboardInitCompleted(GameDetailViewController.self) { (resolver, controller) in
            controller.presnter = resolver.resolve(GameDetailPresenter.self)
        }
        defaultContainer.storyboardInitCompleted(GameFavoriteViewController.self) { (resolver, controller) in
            controller.presenter = resolver.resolve(GetListPresenter.self)
        }
        defaultContainer.storyboardInitCompleted(EditProfileViewViewController.self) { (resolver, controller) in
            controller.presenter = resolver.resolve(EditProfilePresenter.self)
        }
    }
}
