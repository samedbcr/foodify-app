//
//  GamesPageVC.swift
//  VideoGamesApp
//
//  Created by Samed Biçer on 26.07.2021.
//

import UIKit

final class GamesPageVC: UIPageViewController {

    var controllers = [UIViewController]()


    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey: Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        configure()
    }

    private func configure() {
        populatePageVCs(game: nil)
        delegate = self
        dataSource = self
    }

    func populatePageVCs(game: [Game]?) {
        if let game = game {
            controllers.removeAll()
            game.forEach { (game) in
                let vc = GameCarouselVC()
                vc.imageUrl = game.backgroundImage
                vc.gameId = game.id
                controllers.append(vc)
            }
        } else {
            let dummyVC = GameCarouselVC()
            controllers = [dummyVC]
        }

        guard let first = controllers.first else { return }
        setViewControllers([first], direction: .forward, animated: true, completion: nil)
    }
}

extension GamesPageVC: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController), index > 0 else { return nil }
        let prev = index - 1

        return controllers[prev]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = controllers.firstIndex(of: viewController), index < (controllers.count - 1) else { return nil }
        let next = index + 1

        return controllers[next]
    }

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return controllers.count
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let firstVC = pageViewController.viewControllers?.first else { return 0 }
        guard let firstVCIndex = controllers.firstIndex(of: firstVC) else { return 0 }

        return firstVCIndex
    }
}
