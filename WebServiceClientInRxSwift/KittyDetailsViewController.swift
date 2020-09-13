//
//  KittyDetailsViewController.swift
//  WebServiceClientInRxSwift
//
//  Created by Marcin Makurat on 13/09/2020.
//  Copyright © 2020 Marcin Makurat. All rights reserved.
//

import UIKit

class KittyDetailsViewController: UIViewController {
    
    private var viewModel: KittyViewModel!
    
    @IBOutlet var textLabel: UILabel!
    
    static func instiantiate(viewModel: KittyViewModel) ->  KittyDetailsViewController {
        let storyboard = UIStoryboard(name: "KittyStoryboard", bundle: nil)
        guard let viewController = storyboard.instantiateViewController(identifier: "KittyDetailsViewController") as? KittyDetailsViewController else { return KittyDetailsViewController() }
        viewController.viewModel = viewModel
        return viewController
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        textLabel.text = viewModel.displayText
    }
}
