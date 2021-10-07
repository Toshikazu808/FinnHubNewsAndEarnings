//
//  EarningsDetailsCell.swift
//  FromScratch
//
//  Created by Ryan Kanno on 10/6/21.
//

import UIKit

class EarningsDetailsCell: UITableViewCell {
   static let id = "EarningsDetailsCell"
   @IBOutlet private weak var detail: UILabel!
   @IBOutlet private weak var value: UILabel!
   
   override func awakeFromNib() {
      super.awakeFromNib()
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
   }
   
   func configure(detail: EarningsDetail) {
      self.detail.text = detail.lable
      self.value.text = detail.value
   }
}
