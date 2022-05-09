//
//  MainPageViewController.swift
//  D-WORK
//
//  Created by 김신혜 on 2021/11/17.
//

import UIKit

class MainPageViewController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {
    var mainViewController:MainViewController?
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.index(of: viewController) {
               if viewControllerIndex == 0 {
                   // wrap to last page in array
//                   return self.pages.last
                    return nil
               } else {
                   // go to previous page in array
                   return self.pages[viewControllerIndex - 1]
               }
           }
           return nil
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        if let viewControllerIndex = self.pages.index(of: viewController) {
            
                if viewControllerIndex < self.pages.count - 1 {
                    // go to next page in array
                    return self.pages[viewControllerIndex + 1]
                } else {
                    // wrap to first page in array
//                    return self.pages.first
                    return nil
                }
            }
        
            return nil
    }
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return pages.count
    }
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
//        print("page changed previousViewControllers : \(previousViewControllers)")
//        print("transitionCompleted : \(completed)")
        
        if previousViewControllers[0] == pages[0] && completed {
            mainViewController?.changeFromPageViewController(changeTo: MainViewController.MainTab.RegisterWater)
        } else if previousViewControllers[0] == pages[1] && completed {
            mainViewController?.changeFromPageViewController(changeTo: MainViewController.MainTab.WorkingStatus)
        }
    }

    var pages = [UIViewController]()
    let pageControl = UIPageControl()
    
    override init(transitionStyle style: UIPageViewController.TransitionStyle, navigationOrientation: UIPageViewController.NavigationOrientation, options: [UIPageViewController.OptionsKey : Any]? = nil) {
           super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
       }

       required init?(coder: NSCoder) {
           super.init(coder: coder)
       }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSource = self
        self.delegate = self
       
        
        let initialPage = 0
        let page1 = MainWorkingStatusViewController()
        let page2 = MainWaterRegisterViewController()
                
        // add the individual viewControllers to the pageViewController
        self.pages.append(page1)
        self.pages.append(page2)
        setViewControllers([pages[initialPage]], direction: .forward, animated: true, completion: nil)

         // pageControl
//         self.pageControl.frame = CGRect()
//         self.pageControl.currentPageIndicatorTintColor = UIColor.black
//         self.pageControl.pageIndicatorTintColor = UIColor.lightGray
//         self.pageControl.numberOfPages = self.pages.count
//         self.pageControl.currentPage = initialPage
//         self.view.addSubview(self.pageControl)
//         self.pageControl.translatesAutoresizingMaskIntoConstraints = false
//         self.pageControl.bottomAnchor.constraint(equalTo: self.view.bottomAnchor, constant: -5).isActive = true
//         self.pageControl.widthAnchor.constraint(equalTo: self.view.widthAnchor, constant: -20).isActive = true
//         self.pageControl.heightAnchor.constraint(equalToConstant: 20).isActive = true
//         self.pageControl.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
