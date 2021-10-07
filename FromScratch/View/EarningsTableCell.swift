//
//  EarningsTableCell.swift
//  FromScratch
//
//  Created by Ryan Kanno on 10/6/21.
//

import UIKit

class EarningsTableCell: UITableViewCell {
   static let id = "EarningsTableCell"
   @IBOutlet private weak var tableView: UITableView!
   private var earningsCalendar = [EarningsCalendar]()
   private var earningsDetail = [EarningsDetail]()
   
   override func awakeFromNib() {
      super.awakeFromNib()
      setupTableView()
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
   }
   
   func configure(earnings: EarningsCalendar) {
      earningsDetail = [
         EarningsDetail(lable: "Date:", value: earnings.date),
         EarningsDetail(lable: "Eps Actual:", value: String(describing: earnings.epsActual)),
         EarningsDetail(lable: "Eps Estimate:", value: String(describing: earnings.epsEstimate)),
         EarningsDetail(lable: "Hour:", value: earnings.hour),
         EarningsDetail(lable: "Quarter:", value: String(describing: earnings.quarter)),
         EarningsDetail(lable: "Revenue Actual:", value: String(describing: earnings.revenueActual)),
         EarningsDetail(lable: "Revenue Estimate:", value: String(describing: earnings.revenueEstimate)),
         EarningsDetail(lable: "Symbol:", value: earnings.symbol),
         EarningsDetail(lable: "Year:", value: String(describing: earnings.year))
      ]
      tableView.reloadData()
   }
   
   private func setupTableView() {
      tableView.delegate = self
      tableView.dataSource = self
      tableView.register(
         UINib(nibName: EarningsDetailsCell.id, bundle: nil),
         forCellReuseIdentifier: EarningsDetailsCell.id)
   }
}

extension EarningsTableCell: UITableViewDelegate, UITableViewDataSource {
   func numberOfSections(in tableView: UITableView) -> Int {
      return earningsCalendar.count
   }
   
   func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      return 1
   }
   
   func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
      return earningsCalendar[section].symbol
   }
   
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
      let cell = tableView.dequeueReusableCell(
         withIdentifier: EarningsDetailsCell.id,
         for: indexPath) as! EarningsDetailsCell
      cell.configure(detail: earningsDetail[indexPath.row])
      return cell
   }
}
