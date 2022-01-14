//
//  PageController.swift
//  Journal
//
//  Created by Abdeen on 1/13/22.
//

import UIKit

class PageController: UIPageViewController, UIPageViewControllerDataSource, UIPageViewControllerDelegate {

    lazy var subViewControllers: [UIViewController] = {
       return [
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "JournalPageStoryboard") as! JournalPageController,
        UIStoryboard(name: "Main", bundle: nil).instantiateViewController(identifier: "EntriesPageStoryBoard") as! EntriesPageController
       ]
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.delegate = self
        self.dataSource = self
        
        // Do any additional setup after loading the view.
        setViewControllers([subViewControllers[0]], direction: .forward, animated: true, completion: nil)
    }

    required init?(coder: NSCoder) {
        super.init(transitionStyle: .scroll, navigationOrientation: .horizontal, options: nil)
    }
    
    func presentationCount(for pageViewController: UIPageViewController) -> Int {
        return subViewControllers.count
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViewControllers.firstIndex(of: viewController) ?? 0
        if(currentIndex <= 0){
            return nil
        }
        return subViewControllers[currentIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentIndex: Int = subViewControllers.firstIndex(of: viewController) ?? 0
        if(currentIndex >= subViewControllers.count - 1){
            return nil
        }
        return subViewControllers[currentIndex + 1]
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
