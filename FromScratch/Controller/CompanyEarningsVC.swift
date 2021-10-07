//
//  CompanyEarningsVC.swift
//  FromScratch
//
//  Created by Ryan Kanno on 10/6/21.
//

import UIKit

class CompanyEarningsVC: UIViewController {
   private let searchController = UISearchController()
   @IBOutlet weak var tableView: UITableView!
   private var earnings = [EarningsCalendar]()
   
   override func viewDidLoad() {
      super.viewDidLoad()
      loadData()
      setupSearchController()
      setupTableView()
   }
   
   private func loadData() {
      let url = NetworkManager.shared.getEarningsUrl(nil)
      NetworkManager.shared.performRequest(urlString: url, returnType: EarningsData.self) { [weak self] result in
         guard let self = self else { return }
         switch result {
         case .failure(let error):
            print(error)
         case .success(let earnings):
            self.earnings = earnings.earningsCalendar
            DispatchQueue.main.async {
               self.tableView.reloadData()
            }
         }
      }
   }
   
   private func setupSearchController() {
      searchController.searchBar.delegate = self
      searchController.obscuresBackgroundDuringPresentation = true
      searchController.searchBar.placeholder = "search ticker symbol"
      navigationItem.searchController = searchController
      definesPresentationContext = true
   }
   
   private func setupTableView() {
      tableView.delegate = self
      tableView.dataSource = self
      tableView.register(
         UINib(nibName: EarningsTableCell.id, bundle: nil),
         forCellReuseIdentifier: EarningsTableCell.id)
   }
}

extension CompanyEarningsVC: UISearchBarDelegate {
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      guard let text = searchBar.text else { return }
      let url = NetworkManager.shared.getEarningsUrl(text)
      NetworkManager.shared.performRequest(urlString: url, returnType: EarningsData.self) { [weak self] result in
         guard let self = self else { return }
         switch result {
         case .failure(let error):
            print(error)
         case .success(let earnings):
            self.earnings = earnings.earningsCalendar
            DispatchQueue.main.async {
               self.tableView.reloadData()
            }
         }
      }
   }
   
   func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
      searchController.searchBar.text = ""
      searchController.searchBar.placeholder = "search ticker symbol"
   }
}

extension CompanyEarningsVC: UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return earnings.count
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(
         withIdentifier: EarningsTableCell.id,
         for: indexPath) as! EarningsTableCell
      cell.configure(earnings: earnings[indexPath.row])
      return cell
   }
}
