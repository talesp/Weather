//
//  HelpViewController.swift
//  Weather
//
//  Created by Tales Pinheiro De Andrade on 27/10/18.
//  Copyright © 2018 Tales Pinheiro De Andrade. All rights reserved.
//

import UIKit
import WebKit

class HelpViewController: UIViewController {

    private lazy var contentView: WKWebView = {
        let view = WKWebView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()

    override func loadView() {
        self.view = self.contentView
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let url = Bundle.main.url(forResource: "Help", withExtension: "html") else {
            fatalError()
        }
        self.contentView.load(URLRequest(url: url))
    }

}
