//
//  GameFavoriteViewController.swift
//  Submission1GameApp
//
//  Created by izzudin on 18/10/20.
//  Copyright © 2020 izzudin. All rights reserved.
//

import UIKit
import Core
import Games

public class GameFavoriteViewController: UIViewController {
    
    @IBOutlet weak var listGameFavorite: UITableView!
    
    private lazy var noDataLabel = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    private var gameFavorites: [GameItemDetail] = []
    private let gameTableXib = "GameItemTableViewCell"
    private let gameTableCell = "gameCell"
    public var presenter: GetListPresenter<String, [GameItemDetail], Interactor<String, [GameItemDetail], FavoriteRepository<FavoriteLocalDataSource, FavoriteTransformer>>, GameFavoriteViewController>?
    
    public override func viewWillAppear(_ animated: Bool) {
        self.presenter?.getAllGame()
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.listener = self
        
        // Do any additional setup after loading the view.
        self.listGameFavorite.register(
            UINib(nibName: gameTableXib,
                  bundle: Bundle(identifier: "com.izudin.swift.Core")
            ), forCellReuseIdentifier: gameTableCell)
        
        noDataLabel.text = "No Data"
        noDataLabel.textColor = .black
        noDataLabel.textAlignment = .center
        noDataLabel.center = self.view.center
        view.addSubview(noDataLabel)
        
        listGameFavorite.delegate = self
        listGameFavorite.dataSource = self
        listGameFavorite.tableFooterView = UIView()
    }
    
    private func showAllGameFavorite(details: [GameItemDetail]) {
        self.gameFavorites = details
        self.listGameFavorite.reloadData()
        
        if details.isEmpty {
            self.noDataLabel.isHidden = false
            self.listGameFavorite.isHidden = true
        } else {
            self.noDataLabel.isHidden = true
            self.listGameFavorite.isHidden = false
        }
    }
}

extension GameFavoriteViewController: GetListPresenterContractView {
    public typealias Result = [GameItemDetail]
    
    public func onGetResult(result: [GameItemDetail]) {
        showAllGameFavorite(details: result)
    }
}

extension GameFavoriteViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameFavorites.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if let cell = tableView.dequeueReusableCell(withIdentifier: gameTableCell, for: indexPath) as? GameTableViewCell {
            
            let game = gameFavorites[indexPath.row]
            cell.gameTitleItem.text = game.name
            
            cell.gameDateItem.text = game.released.toDate()
            cell.gameRatingItem.text = "rating \(game.rating)"
            cell.gameImageItem.clipsToBounds = true
            cell.gameImageItem.sd_setImage(with: URL(string: game.backgroundImage),
                                           placeholderImage: #imageLiteral(resourceName: "placeholder_landscape"))
            
            return cell
        }
        
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "moveToDetail", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? GameDetailViewController {
            guard let index = listGameFavorite.indexPathForSelectedRow?.row else {
                return
            }
            
            print("The index is \(gameFavorites[index].idGame)")
            destination.idGame = String(gameFavorites[index].idGame)
        }
    }
    
}
