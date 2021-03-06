//
//  Extensions.swift
//  FromScratch
//
//  Created by Ryan Kanno on 10/6/21.
//

import UIKit

extension UIImageView {
   func load(urlString: String) {
      guard let url = URL(string: urlString) else { return }
      DispatchQueue.main.async { [weak self] in
         guard let self = self else { return }
         guard let data = try? Data(contentsOf: url) else { return }
         guard let img = UIImage(data: data) else { return }
         DispatchQueue.main.async {
            self.image = img
         }
      }
   }
}

