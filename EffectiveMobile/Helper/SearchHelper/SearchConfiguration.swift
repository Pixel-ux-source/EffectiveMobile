//
//  SearchTableHeader.swift
//  EffectiveMobile
//
//  Created by Алексей on 30.04.2025.
//

import UIKit

struct SearchConfiguration {
    static func make(for vc: UISearchResultsUpdating) -> UISearchController {
        let searchController = UISearchController(searchResultsController: nil)
        
        if let iconView = searchController.searchBar.searchTextField.leftView as? UIImageView {
            iconView.tintColor = UIColor.whiteCustom.withAlphaComponent(0.5)
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            searchController.searchBar.searchTextField.textColor = .whiteCustom
            searchController.searchBar.searchTextField.backgroundColor = .clear
        }
        
        searchController.searchBar.searchTextField.attributedPlaceholder = NSAttributedString(
            string: "Поиск",
            attributes: [
                .foregroundColor: UIColor.whiteCustom.withAlphaComponent(0.5),
                .font: UIFont(name: "SFProText-Regular", size: 17)!,
                .kern: -0.41
            ])
        
        searchController.searchBar.tintColor = .yellowCustom
        searchController.searchBar.barTintColor = .grayCustom

        searchController.searchResultsUpdater = vc
        searchController.obscuresBackgroundDuringPresentation = false
        
        return searchController
    }
}
