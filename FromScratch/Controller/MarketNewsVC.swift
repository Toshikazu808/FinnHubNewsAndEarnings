//
//  ViewController.swift
//  FromScratch
//
//  Created by Ryan Kanno on 10/6/21.
//

import UIKit

class MarketNewsVC: UIViewController {
   @IBOutlet private weak var collectionView: UICollectionView!
   @IBOutlet private weak var tableView: UITableView!
   private let category = ["General", "Forex", "Crypto", "Merger"]
   private var news = [MarketNews]()
   private var newsUrl = ""
   
   override func viewDidLoad() {
      super.viewDidLoad()
      getData()
      setupTableView()
      setupCollectionView()
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.destination is NewsPageVC {
         let vc = segue.destination as? NewsPageVC
         vc?.url = newsUrl
      }
   }
   
   private func getData() {
      let url = NetworkManager.shared.getMarketUrl("general")
      NetworkManager.shared.performRequest(urlString: url, returnType: [MarketNews].self) { [weak self] result in
         guard let self = self else { return }
         switch result {
         case .failure(let error):
            print(error)
         case .success(let news):
            self.news = news
            self.tableView.reloadData()
         }
      }
   }

   private func setupTableView() {
      tableView.isUserInteractionEnabled = true
      tableView.delegate = self
      tableView.dataSource = self
      tableView.register(
         UINib(nibName: MarketTableCell.id, bundle: nil),
         forCellReuseIdentifier: MarketTableCell.id)
   }
   
   private func setupCollectionView() {
      collectionView.delegate = self
      collectionView.dataSource = self
      collectionView.register(
         UINib(nibName: MarketSelectionCell.id, bundle: nil),
         forCellWithReuseIdentifier: MarketSelectionCell.id)
   }
}

extension MarketNewsVC: UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return news.count
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return UIScreen.main.bounds.height * 0.2
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(withIdentifier: MarketTableCell.id, for: indexPath) as! MarketTableCell
      cell.configure(news: news[indexPath.row])
      return cell
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
      newsUrl = news[indexPath.row].url
      performSegue(withIdentifier: "ToNewsPage", sender: nil)
   }
}

extension MarketNewsVC: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
   func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
      return category.count
   }
   
   func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
      let cell = collectionView.dequeueReusableCell(
         withReuseIdentifier: MarketSelectionCell.id,
         for: indexPath) as! MarketSelectionCell
      cell.configure(category[indexPath.row])
      cell.layoutIfNeeded()
      return cell
   }
   
   func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
      let url = NetworkManager.shared.getMarketUrl(category[indexPath.row])
      NetworkManager.shared.performRequest(urlString: url, returnType: [MarketNews].self) { [weak self] result in
         guard let self = self else { return }
         switch result {
         case .failure(let error):
            print(error)
         case .success(let news):
            self.news = news
            DispatchQueue.main.async {
               self.tableView.reloadData()
            }
         }
      }
   }
   
   func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
      let cellWidth = UIScreen.main.bounds.width * 0.6
      let cellHeight: CGFloat = collectionView.bounds.height * 0.8
      return CGSize(width: cellWidth, height: cellHeight)
   }
}
