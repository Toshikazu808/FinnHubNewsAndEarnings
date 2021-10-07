//
//  MarketNewsCEll.swift
//  FromScratch
//
//  Created by Ryan Kanno on 10/6/21.
//

import UIKit

class MarketTableCell: UITableViewCell {
   static let id = "MarketTableCell"
   static let height: CGFloat = 75
   @IBOutlet weak var headline: UILabel!
   @IBOutlet weak var content: UILabel!
   @IBOutlet weak var picture: UIImageView!
   
   override func awakeFromNib() {
      super.awakeFromNib()
      self.isUserInteractionEnabled = true
      picture.layer.cornerRadius = 6
   }
   
   override func setSelected(_ selected: Bool, animated: Bool) {
      super.setSelected(selected, animated: animated)
   }
   
   func configure(news: MarketNews) {
      headline.text = news.headline
      content.text = news.summary
      picture.load(urlString: news.image)
   }
}
