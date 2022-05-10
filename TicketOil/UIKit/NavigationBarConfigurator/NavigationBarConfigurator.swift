//
//  NavigationBarConfigurator.swift
//  TicketOil
//
//  Created by Nursat on 19.04.2022.
//

import UIKit

// MARK: - NavigationBarStyle

enum NavigationBarStyle {
    case `default`(
        prefersLargeTitles: Bool = false,
        needsToDisplayShadow: Bool = true
    )
    case transparent
}

// MARK: - NavigationBarConfigurator

protocol NavigationBarConfigurator: AnyObject {
    func configure(navigationBar: UINavigationBar, with style: NavigationBarStyle)
}

// MARK: - NavigationBarConfigurator + Default Style

extension NavigationBarConfigurator {
    public func configure(navigationBar: UINavigationBar) {
        configure(
            navigationBar: navigationBar,
            with: .default()
        )
    }
}

final class NavigationBarConfiguratorImpl: NavigationBarConfigurator {
    func configure(navigationBar: UINavigationBar, with style: NavigationBarStyle) {
        switch style {
        case let .default(prefersLargeTitles, needsToDisplayShadow):
            configureDefaultNavigationBar(
                navigationBar,
                prefersLargeTitles: prefersLargeTitles,
                needsToDisplayShadow: needsToDisplayShadow
            )
        case .transparent:
            configureTranspartNavigationBar(navigationBar)
        }
    }
    
    private func configureDefaultNavigationBar(
        _ navigationBar: UINavigationBar,
        prefersLargeTitles: Bool,
        needsToDisplayShadow: Bool
    ) {
        navigationBar.prefersLargeTitles = prefersLargeTitles
        navigationBar.scrollEdgeAppearance = makeDefaultNavigationBarAppearance(
            needsToDisplayShadow: prefersLargeTitles ? false : needsToDisplayShadow
        )
        navigationBar.standardAppearance = makeDefaultNavigationBarAppearance(
            needsToDisplayShadow: needsToDisplayShadow
        )
        navigationBar.tintColor = UIColor(hex: "#FFFFFF")
    }
    
    private func configureTranspartNavigationBar(_ navigationBar: UINavigationBar) {
        navigationBar.scrollEdgeAppearance = makeTransparentNavigationBarAppearance()
        navigationBar.standardAppearance = makeTransparentNavigationBarAppearance()
    }
    
    private func makeDefaultNavigationBarAppearance(needsToDisplayShadow: Bool) -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance(idiom: .phone)
        appearance.configureWithOpaqueBackground()
        appearance.backgroundColor = UIColor(hex: "#D61616")
        appearance.largeTitleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 28, weight: .bold),
            .foregroundColor: UIColor(hex: "#FFFFFF")!
        ]
        appearance.shadowColor = needsToDisplayShadow ? UIColor(hex: "#E4E4E4") : nil
        appearance.titleTextAttributes = [
            .font: UIFont.systemFont(ofSize: 18, weight: .semibold),
            .foregroundColor: UIColor(hex: "#FFFFFF")!
        ]
        return appearance
    }
    
    private func makeTransparentNavigationBarAppearance() -> UINavigationBarAppearance {
        let appearance = UINavigationBarAppearance(idiom: .phone)
        appearance.configureWithTransparentBackground()
        return appearance
    }
}
