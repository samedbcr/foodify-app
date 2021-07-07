//
//  PageViewController.swift
//  Week-3
//
//  Created by Samed Biçer on 7.07.2021.
//

import UIKit

class PageViewController: UIViewController {

    var controllers = [UIViewController]()
    let pageVC = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    let firstPageVC = FirstPageVC()
    let secondPageVC = SecondPageVC()
    let thirdPageVC = ThirdPageVC()
    let pageControl = UIPageControl()

    override func viewDidLoad() {
        super.viewDidLoad()

        populateVCs()
        configurePageVC()
        configurePageControl()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        configurePageVC()
    }

    private func populateVCs() {
        controllers = [firstPageVC, secondPageVC, thirdPageVC]
    }

    private func configurePageVC() {
        guard let first = controllers.first else { return }
        pageVC.dataSource = self
        pageVC.delegate = self
        pageVC.setViewControllers([first], direction: .forward, animated: true, completion: nil)
        view.addSubview(pageVC.view)
    }

    private func configurePageControl() {
        view.addSubview(pageControl)
        pageControl.translatesAutoresizingMaskIntoConstraints = false
        pageControl.numberOfPages = controllers.count
        pageControl.currentPage = 0
        pageControl.currentPageIndicatorTintColor = UIColor.black
        pageControl.pageIndicatorTintColor = UIColor.lightGray

        NSLayoutConstraint.activate([
            pageControl.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -5),
            pageControl.centerXAnchor.constraint(equalTo: view.centerXAnchor),

        ])
    }
}

extension PageViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
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

    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if let viewControllers = pageViewController.viewControllers {
            if let viewControllerIndex = controllers.firstIndex(of: viewControllers[0]) {
                pageControl.currentPage = viewControllerIndex
            }
        }
    }
}
