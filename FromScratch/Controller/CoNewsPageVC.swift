//
//  CoNewsPageVC.swift
//  FromScratch
//
//  Created by Ryan Kanno on 10/6/21.
//

import UIKit
import WebKit

class CoNewsPageVC: UIViewController {
   var url = ""
   @IBOutlet private weak var webView: WKWebView!
   
   override func viewDidLoad() {
      super.viewDidLoad()
      if let url = URL(string: url) {
         webView.load(URLRequest(url: url))
      } else {
         showErrorLoading()
      }
   }
   
   private func showErrorLoading() {
      let alert = UIAlertController(
         title: "Error",
         message: "Error loading page",
         preferredStyle: .alert)
      alert.addAction(UIAlertAction(
         title: "Dismiss",
         style: .default,
         handler: { _ in
            self.navigationController?.popViewController(animated: true)
      }))
      present(alert, animated: true)
   }
}
