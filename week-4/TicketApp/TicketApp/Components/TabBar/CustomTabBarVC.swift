//
//  CustomTabBarVC.swift
//  TicketApp
//
//  Created by Samed Biçer on 30.07.2021.
//

import UIKit

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

        let homeVC = TicketVC()
        let homeVCTabBar = UITabBarItem(title: "", image: UIImage(named: "home"), tag: 0)
        homeVC.tabBarItem = homeVCTabBar

        let vc2 = HomeVC()
        vc2.title = ""

        let vc3 = ThirdVC()
        let vc3TabBar = UITabBarItem(title: "", image: UIImage(named: "avatar"), tag: 2)
        vc3.tabBarItem = vc3TabBar

        viewControllers = [homeVC, vc2, vc3]

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
