//
//  GameDetailViewController.swift
//  Submission1GameApp
//
//  Created by izzudin on 02/08/20.
//  Copyright © 2020 izzudin. All rights reserved.
//

import UIKit
import Core

public class GameDetailViewController: UIViewController {
    
    @IBOutlet weak var gameImage: UIImageView!
    @IBOutlet weak var gameTitle: UILabel!
    @IBOutlet weak var gameRating: UILabel!
    @IBOutlet weak var gameDescription: UILabel!
    @IBOutlet weak var gameDate: UILabel!
    @IBOutlet weak var favoriteButton: UIBarButtonItem!
    @IBOutlet weak var scrollViewParent: UIScrollView!
    
    private lazy var isFavorited = false
    private let activityIndicator = UIActivityIndicatorView()
    private let retryButton = UIButton()
    private var gameDetail: GameItemDetail?
    public var presnter: GameDetailPresenter?
    public var idGame: String = ""
    
    public override func viewWillAppear(_ animated: Bool) {
        presnter?.listener = self
        presnter?.getGame(idGame: idGame)
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        view.addSubview(activityIndicator)
        
        retryButton.setTitle("Retry", for: .normal)
        retryButton.setTitleColor(.blue, for: .normal)
        retryButton.center = self.view.center
        retryButton.addTarget(self, action: #selector(self.reloadData), for: .touchUpInside)
        retryButton.isHidden = true
        view.addSubview(retryButton)
        
        getGameData(idGame: idGame)
    }
    
    private func setFavoriteFlag(flag: Bool, image: UIImage?) {
        self.isFavorited = flag
        self.favoriteButton.image = image
    }
    
    @IBAction func saveToDatabase(_ sender: UIBarButtonItem) {
        if isFavorited, let idGame = Int(idGame) {
            presnter?.deleteGame(idGame: idGame)
        } else if let game = gameDetail {
            presnter?.saveFavorite(game: game)
        }
    }
    
    @objc func reloadData() {
        getGameData(idGame: idGame)
    }
    
    private func getGameData(idGame: String) {
        presnter?.getDetailGame(idGame: idGame)
    }
}

extension GameDetailViewController: GameDetailContractView {
    public func onStopLoading() {
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
        scrollViewParent.isHidden = false
    }
    
    public func onStartLoading() {
        scrollViewParent.isHidden = true
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    public func onGettingGame(item: GameItemDetail) {
        setFavoriteFlag(flag: true, image: UIImage(systemName: "star.fill"))
    }
    
    public func onSavedGame() {
        setFavoriteFlag(flag: !self.isFavorited, image: UIImage(systemName: "star.fill"))
    }
    
    public func onDeletedGame() {
        setFavoriteFlag(flag: !self.isFavorited, image: UIImage(systemName: "star"))
    }
    
    public func onGettingDetailGame(item: GameItemDetail) {
        self.gameDetail = item
        self.gameTitle.text = item.name
        self.gameDate.text = item.released.toDate()
        self.gameRating.text = "rating \(item.rating)"
        self.gameDescription.text = item.description
        self.gameImage.sd_setImage(with: URL(string: item.backgroundImage), placeholderImage: #imageLiteral(resourceName: "placeholder_landscape"))
    }
}

extension String {
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else {
            return nil
        }
        
        do {
            return try NSAttributedString(data: data, options: [
                .documentType: NSAttributedString.DocumentType.html,
                .characterEncoding: String.Encoding.utf8.rawValue
            ], documentAttributes: nil)
        } catch {
            return nil
        }
    }
}
