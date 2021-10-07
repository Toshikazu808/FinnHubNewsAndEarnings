//
//  MarketSelectionCell.swift
//  FromScratch
//
//  Created by Ryan Kanno on 10/6/21.
//

import UIKit

class MarketSelectionCell: UICollectionViewCell {
   static let id = "MarketSelectionCell"
   @IBOutlet weak var category: UILabel!
   @IBOutlet weak var picture: UIImageView!
   
   override func awakeFromNib() {
      super.awakeFromNib()
   }
   
   func configure(_ selection: String) {
      category.text = selection
      picture.image = UIImage(named: selection)
   }
}
