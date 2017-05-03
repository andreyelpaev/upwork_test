//
//  ListPageViewController.swift
//  TestToUpwork
//
//  Created by Andrey Elpaev on 02/05/2017.
//  Copyright © 2017 ClearSofrware. All rights reserved.
//

import UIKit


protocol SwipeDelegate: class {
    func swipe(_ type: Type)
}

class ListPageViewController: UIPageViewController, BarTapDelegate {
    
    var point: CGFloat = 0.0
    var controllers = [UIViewController]()
    var mainController: ViewController!
    weak var swipeDelegate: SwipeDelegate?
    var googleMapController: GoogleMapViewController!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataSource = self
        delegate = self

        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        
        let distController = storyBoard.instantiateViewController(withIdentifier: "list") as! ListTableViewController
        let costController = storyBoard.instantiateViewController(withIdentifier: "list")as! ListTableViewController
        
        googleMapController.setDelegate(distController)
        googleMapController.setDelegate(costController)
        
        distController.type = .distance
        costController.type = .cost
        
        controllers = [distController, costController]
        mainController.delegate = self
        
        if let firstController = controllers.first {
            self.setViewControllers([firstController], direction: .forward, animated: true, completion: nil)
        }
    }
    
    func tap(_ type: Type) {
        
        if type == .distance {
            
            if let firstController = controllers.first {
                self.setViewControllers([firstController], direction: .reverse, animated: true, completion: nil)
            }
        }
        
        if type == .cost {
            if let lastController = controllers.last {
                self.setViewControllers([lastController], direction: .forward, animated: true, completion: nil)
            }
        }
    }
}

extension ListPageViewController: UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = self.controllers.index(of: viewController) else {
            return nil
        }
        
        let previousIndex = viewControllerIndex - 1
        
        guard previousIndex >= 0 else {
            return nil
        }
        
        guard self.controllers.count > previousIndex else {
            return nil
        }

        
        return self.controllers[previousIndex]
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let viewControllerIndex = self.controllers.index(of: viewController) else {
            return nil
        }
        
        let nextIndex = viewControllerIndex + 1
        let cashDesksViewControllersCount = self.controllers.count
        
        guard cashDesksViewControllersCount != nextIndex else {
            return nil
        }
        
        guard cashDesksViewControllersCount > nextIndex else {
            return nil
        }
        
        
        
        return self.controllers[nextIndex]
    }

    func presentationIndex(for pageViewController: UIPageViewController) -> Int {
        
        guard let firstViewController = self.viewControllers?.first,
            let firstViewControllerIndex = self.controllers.index(of: firstViewController) else {
                return 0
        }
        
        
        return firstViewControllerIndex
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        
        guard completed else { return }
        
        if let controller = pageViewController.viewControllers?.last as? ListTableViewController {
            swipeDelegate?.swipe(controller.type)
        }
    }
    
}
