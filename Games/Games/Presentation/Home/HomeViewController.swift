//
//  ViewController.swift
//  Submission1GameApp
//
//  Created by izzudin on 01/08/20.
//  Copyright © 2020 izzudin. All rights reserved.
//

import UIKit
import SDWebImage
import RxSwift
import RxCocoa
import Core

public class HomeViewController: UIViewController {
    
    @IBOutlet weak var searchGameBar: UISearchBar!
    @IBOutlet weak var listGame: UITableView!
    
    private var gameArray = [GameItem]()
    private let gameTableXib = "GameItemTableViewCell"
    private let gameTableCell = "gameCell"
    private let gameDetailControllerConstant = "GameDetailViewController"
    private let disposeBag = DisposeBag()
    
    private let activityIndicator = UIActivityIndicatorView()
    private let retryButton = UIButton()
    private lazy var noDataFound = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: 21))
    
    public var presenter: HomePresenter?
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        presenter?.listener = self
        observeTextChanges()
        
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.style = .medium
        view.addSubview(activityIndicator)
        
        noDataFound.text = "No Data Found"
        noDataFound.textColor = .black
        noDataFound.textAlignment = .center
        noDataFound.center = self.view.center
        noDataFound.isHidden = true
        view.addSubview(noDataFound)
        
        retryButton.setTitle("Retry", for: .normal)
        retryButton.setTitleColor(.blue, for: .normal)
        retryButton.center = self.view.center
        retryButton.addTarget(self, action: #selector(self.reloadData), for: .touchUpInside)
        retryButton.isHidden = true
        view.addSubview(retryButton)
        
        listGame.delegate = self
        listGame.dataSource = self
        listGame.register(UINib(nibName: gameTableXib, bundle: Bundle(identifier: "com.izudin.swift.Core")), forCellReuseIdentifier: gameTableCell)
        listGame.tableFooterView = UIView()
        searchGameBar.placeholder = "Search a game here"
        
        presenter?.getListItem()
    }
    
    @objc func reloadData() {
        if let query = searchGameBar.text, !query.isEmpty {
            presenter?.searchGame(query: query)
        } else {
            presenter?.getListItem()
        }
        
        retryButton.isHidden = true
    }
    
    private func observeTextChanges() {
        searchGameBar.rx.text
            .observeOn(MainScheduler.asyncInstance)
            .debounce(0.5, scheduler: MainScheduler.instance)
            .bind { (searchText) in
                if let query = searchText, !query.isEmpty {
                    self.presenter?.searchGame(query: query)
                } else {
                    self.presenter?.getListItem()
                }
            }.disposed(by: disposeBag)
        
    }
    
    private func showGameList(items: [GameItem]) {
        if items.isEmpty {
            self.noDataFound.isHidden = false
            self.listGame.isHidden = true
        } else {
            self.noDataFound.isHidden = true
            self.listGame.isHidden = false
        }
        
        self.gameArray = items
        self.listGame.reloadData()
    }
}

extension HomeViewController: HomeContractView {
    public func onGetListItem(items: [GameItem]) {
        showGameList(items: items)
    }
    
    public func onGameFound(items: [GameItem]) {
        showGameList(items: items)
    }
    
    public func onStartLoading() {
        listGame.isHidden = true
        noDataFound.isHidden = true
        activityIndicator.startAnimating()
        view.isUserInteractionEnabled = false
    }
    
    public func onStopLoading() {
        activityIndicator.stopAnimating()
        view.isUserInteractionEnabled = true
        listGame.isHidden = false
    }
    
    public func onErrorState(error: Error) {
        self.retryButton.isHidden = false
    }
}

extension HomeViewController: UITableViewDelegate, UITableViewDataSource {
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return gameArray.count
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if let cell = tableView.dequeueReusableCell(withIdentifier: gameTableCell, for: indexPath) as? GameTableViewCell {
            
            if indexPath.row < gameArray.count {
                let game = gameArray[indexPath.row]
                cell.gameTitleItem.text = game.name
                cell.gameRatingItem.text = "rating \(String(describing: game.rating))"
                cell.gameDateItem.text = game.released.toDate()
                cell.gameImageItem.sd_setImage(with: URL(string: game.backgroundImage), placeholderImage: #imageLiteral(resourceName: "placeholder_potrait"))
                
                return cell
            }
        }
        
        return UITableViewCell()
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showGameDetail", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? GameDetailViewController {
            guard let index = listGame.indexPathForSelectedRow?.row else {
                return
            }
            destination.idGame = String(gameArray[index].idGame)
        }
    }
}

extension String {
    
    public func toDate() -> String {
        if self != "-" {
            let dateFormaterInput = DateFormatter()
            dateFormaterInput.dateFormat = "yyyy-MM-dd"
            let resultInputDate = dateFormaterInput.date(from: self)
            
            let dateFormatterOutput = DateFormatter()
            dateFormatterOutput.locale = .current
            dateFormatterOutput.dateFormat = "dd MMM YYYY"
            let resultOutoutDate = dateFormatterOutput.string(from: resultInputDate ?? Date())
            
            return resultOutoutDate
        } else {
            return "-"
        }
    }
}
