//
//  ViewController.swift
//  WebServiceClientInRxSwift
//
//  Created by Marcin Makurat on 13/09/2020.
//  Copyright © 2020 Marcin Makurat. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

class ViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    private let disposeBag = DisposeBag()
    private var viewModel: RestaurantsListViewModel!
    
    static func instantiate(viewModel: RestaurantsListViewModel) -> ViewController {
        let storyboard = UIStoryboard(name: "Main", bundle: .main)
        guard let viewController = storyboard.instantiateInitialViewController() as? ViewController else { return ViewController() }
        viewController.viewModel = viewModel
        return viewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.fetchRestaurantViewModels()
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: "cell")) { index, viewModel, cell in
                cell.textLabel?.text = viewModel.displayText }
            .disposed(by: disposeBag)
        
        tableView.rx.itemSelected
            .subscribe(onNext: { [weak self] indexPath in
                let kittyViewController = KittyDetailsViewController.instiantiate(viewModel: KittyViewModel())
                self?.navigationController?.pushViewController(kittyViewController, animated: true)
            })
            .disposed(by: disposeBag)
        
//        let client = Client()
    }


}

