//
//  CustomTabBarVC.swift
//  Foodify
//
//  Created by Samed Biçer on 15.08.2021.
//

import UIKit
import FoodifyAPI

class CustomTabBarVC: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        configureTabBar()
        setupTabBarShadow()
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tabBar.tintColor = .darkGray
        tabBar.unselectedItemTintColor = .lightGray
        tabBar.backgroundColor = .white
        tabBar.isTranslucent = false

        let homeVC = HomeViewController()
        let homeViewModel = HomeViewModel(categoryService: CategoryService(), productService: ProductService())
        homeVC.viewModel = homeViewModel
        let homeVCTabBar = UITabBarItem(tabBarSystemItem: .search, tag: 0)
        homeVC.tabBarItem = homeVCTabBar

        let cartVC = CartViewController()
        let cartViewModel = CartViewModel(service: CartService())
        cartVC.viewModel = cartViewModel
        cartVC.title = ""

        let vc3 = ViewController()
        let vc3TabBar = UITabBarItem(tabBarSystemItem: .favorites, tag: 2)
        vc3.tabBarItem = vc3TabBar

        viewControllers = [homeVC, cartVC, vc3]

        configureMiddleButton()
    }

    private func configureMiddleButton() {
        let middleButtonView = TabBarMiddleButtonView()
        view.addSubview(middleButtonView)
        middleButtonView.button.addTarget(self, action: #selector(middleButtonAction(sender:)), for: .touchUpInside)

        NSLayoutConstraint.activate([
            middleButtonView.topAnchor.constraint(equalTo: tabBar.topAnchor, constant: -20),
            middleButtonView.centerXAnchor.constraint(equalTo: tabBar.centerXAnchor),
            middleButtonView.widthAnchor.constraint(equalToConstant: 64),
            middleButtonView.heightAnchor.constraint(equalToConstant: 64),
        ])

        view.layoutIfNeeded()
    }

    private func configureTabBar() {
        // removes upper border line of the TabBar
        let appearance = tabBar.standardAppearance
        appearance.configureWithOpaqueBackground()
        appearance.shadowImage = nil
        appearance.shadowColor = nil
        tabBar.standardAppearance = appearance
    }

    private func setupTabBarShadow() {
        self.tabBar.layer.shadowColor = UIColor(red: 0, green: 0, blue: 0, alpha: 0.25).cgColor
        self.tabBar.layer.shadowOffset = CGSize(width: 0, height: 2)
        self.tabBar.layer.shadowOpacity = 1.0
        self.tabBar.layer.shadowRadius = 10
        self.tabBar.layer.masksToBounds = false
    }

    @objc private func middleButtonAction(sender: UIButton) {
        selectedIndex = 1
    }
}
