//
//  OnboardingViewController.swift
//  TMDB Project
//
//  Created by yeoni on 2023/08/27.
//

import UIKit

class OnboardingViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    var list: [UIViewController] = []
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal)
        // 이후에 pageView에서 기본으로 제공하는 pageViewControl을 사용하기 위해서 scroll / horizontal로 사용했음 ^_^
    }
    
    // 스토리보드를 혹시? 사용할지도? 모르니까
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        list = [FirstViewController(), SecondViewController(), ThirdiewController()]
        
        delegate = self
        dataSource = self
        
        guard let first = list.first else { return }
        setViewControllers([first], direction: .forward, animated: true)
        
    }
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        let previousIndex = currentIndex - 1
        
        return previousIndex < 0 ? nil : list[previousIndex]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let currentIndex = list.firstIndex(of: viewController) else { return nil }
        let nextIndex = currentIndex + 1
        
        return nextIndex >= list.count ? nil : list[nextIndex]
    }
    

    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        // 총 페이지를 얼마나 준비하까?
        return list.count
    }
    
    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        guard let first = viewControllers?.first, let index = list.firstIndex(of: first) else { return 0}
        return index
    }
}
