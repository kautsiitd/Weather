//
//  HomePageVC.swift
//  Weather
//
//  Created by Kautsya Kanu on 21/02/21.
//

import UIKit
class HomePageVC: UIPageViewController {
    
}

extension HomePageVC: UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        return nil
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        return nil
    }
}

extension HomePageVC: UIPageViewControllerDelegate {
    
}
