//
//  CompanyNewsVC.swift
//  FromScratch
//
//  Created by Ryan Kanno on 10/6/21.
//

import UIKit

class CompanyNewsVC: UIViewController {
   private let searchController = UISearchController()
   @IBOutlet private weak var tableView: UITableView!
   private var companyNews = [CompanyNews]()
   private var url = ""
   
   override func viewDidLoad() {
      super.viewDidLoad()
      loadData()
      setupSearchController()
      setupTableView()
   }
   
   override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
      if segue.destination is CoNewsPageVC {
         guard let vc = segue.destination as? CoNewsPageVC else { return }
         vc.url = url
      }
   }
   
   private func loadData() {
      let url = NetworkManager.shared.getCompanyUrl("AAPL")
      NetworkManager.shared.performRequest(urlString: url, returnType: [CompanyNews].self) { [weak self] result in
         guard let self = self else { return }
         switch result {
         case .failure(let error):
            print(error)
         case .success(let news):
            self.companyNews = news
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
         UINib(nibName: CompanyTableCell.id, bundle: nil),
         forCellReuseIdentifier: CompanyTableCell.id)
   }
   
}

extension CompanyNewsVC: UISearchBarDelegate {
   func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
      guard let text = searchBar.text else { return }
      let url = NetworkManager.shared.getCompanyUrl(text)
      NetworkManager.shared.performRequest(urlString: url, returnType: [CompanyNews].self) { [weak self] result in
         guard let self = self else { return }
         switch result {
         case .failure(let error):
            print(error)
         case .success(let news):
            self.companyNews = news
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

extension CompanyNewsVC: UITableViewDelegate, UITableViewDataSource {
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return companyNews.count
   }
   
   func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
      return 100
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(
         withIdentifier: CompanyTableCell.id,
         for: indexPath) as! CompanyTableCell
      cell.configure(company: companyNews[indexPath.row])
      return cell
   }
   
   func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      tableView.deselectRow(at: indexPath, animated: true)
      url = companyNews[indexPath.row].url
      performSegue(withIdentifier: "ToCoNewsPage", sender: nil)
   }
}
