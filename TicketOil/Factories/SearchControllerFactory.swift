//
//  SearchControllerFactory.swift
//  TicketOil
//
//  Created by Nursat on 05.06.2022.
//

import Foundation
import UIKit

final class SearchControllerFactory {
    func makeSearchController(searchResultsController: UIViewController) -> UISearchController {
        let searchController = UISearchController(searchResultsController: searchResultsController)
        searchController.obscuresBackgroundDuringPresentation = false
        
        let searchBar = searchController.searchBar
        searchBar.returnKeyType = .done
        searchBar.setImage(UIImage(), for: .search, state: .normal)
        searchBar.setSearchFieldBackgroundImage(UIImage(), for: .normal)
        searchBar.setPositionAdjustment(
            UIOffset(horizontal: 6, vertical: 0),
            for: .search
        )
        configure(textField: searchBar.searchTextField)
        
        return searchController
    }
    
    private func configure(textField: UISearchTextField) {
        textField.attributedPlaceholder = NSAttributedString(
            string: "Что будем искать?",
            attributes: [
                .font: UIFont.systemFont(ofSize: 16, weight: .regular),
                .foregroundColor: UIColor.black
            ]
        )
        
        textField.tintColor = .black
        textField.backgroundColor = .white
        textField.clipsToBounds = true
        textField.layer.cornerRadius = 18
        textField.leftView?.tintColor = .black
    }
}
