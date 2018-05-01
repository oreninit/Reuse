//
//  Navigator.swift
//  Reuse_Example
//
//  Created by Oren F on 12/04/2018.
//  Copyright © 2018 CocoaPods. All rights reserved.
//

import UIKit
import Reuse

protocol Navigator {
    func showTable(of data: PeopleDatabase)
    func showCollection(of data: PeopleDatabase)
    func showDetails(of person: PersonViewModel)
}

struct ApplicationNavigator: Navigator {
    
    let navigationController: UINavigationController?
    
    func showTable(of data: PeopleDatabase) {
        guard let viewcController = navigationController?.storyboard?.instantiateViewController(withIdentifier: "TableViewController") as? TableViewController else { return }
        viewcController.data = data
        viewcController.navigator = self
        navigationController?.pushViewController(viewcController, animated: true)
    }
    
    func showCollection(of data: PeopleDatabase) {
        guard let viewcController = navigationController?.storyboard?.instantiateViewController(withIdentifier: "CollectionViewController") as? CollectionViewController else { return }
        viewcController.data = data
        viewcController.navigator = self
        navigationController?.pushViewController(viewcController, animated: true)
    }
    
    func showDetails(of person: PersonViewModel) {
        guard let details = navigationController?.storyboard?.instantiateViewController(withIdentifier: "DetailsViewController") as? DetailsViewController else { return }
        details.viewModel = person
        navigationController?.pushViewController(details, animated: true)
    }
}
