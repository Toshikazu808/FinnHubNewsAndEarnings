//
//  CompanyTableCell.swift
//  FromScratch
//
//  Created by Ryan Kanno on 10/6/21.
//

import UIKit

class CompanyTableCell: UITableViewCell {
   static let id = "CompanyTableCell"
   @IBOutlet weak private var headline: UILabel!
   @IBOutlet weak private var summary: UILabel!
   @IBOutlet weak private var source: UILabel!
   @IBOutlet weak private var picture: UIImageView!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      picture.layer.cornerRadius = 6
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
   }
   
   func configure(company: CompanyNews) {
      headline.text = company.headline
      summary.text = company.summary
      source.text = "Source: \(company.source)"
      picture.load(urlString: company.image)
   }
}
