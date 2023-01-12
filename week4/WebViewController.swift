//
//  MapViewController.swift
//  week5
//
//  Created by Ali serkan Boyracı  on 11.01.2023.
//

import UIKit
import WebKit

class WebViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let url = URL(string: "https://www.adobe.com/support/products/enterprise/knowledgecenter/media/c4611_sample_explain.pdf") {
            let request: URLRequest = .init(url: url)
            webView.load(request)
        }
    }
}
