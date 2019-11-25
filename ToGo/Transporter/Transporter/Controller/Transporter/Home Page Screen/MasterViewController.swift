//
//  MasterViewController.swift
//  ViewControllerContainment
//
//  Created by Bart Jacobs on 01/05/16.
//  Copyright © 2016 Bart Jacobs. All rights reserved.
//

import UIKit

final class MasterViewController: UIViewController {

    @IBOutlet var segmentedControl: UISegmentedControl!
     static var segmentedControlIndex = 0
    private lazy var ordersViewController: AvailableOrderViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "BidEngin", bundle: Bundle.main)

        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "AvailableOrderViewController") as! AvailableOrderViewController

        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)

        return viewController
    }()

    
    private lazy var currentOrderViewController: CurrentOrderViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "BidEngin", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "CurrentOrderViewController") as! CurrentOrderViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()

    private lazy var previousViewController: PreviousViewController = {
        // Load Storyboard
        let storyboard = UIStoryboard(name: "BidEngin", bundle: Bundle.main)
        
        // Instantiate View Controller
        var viewController = storyboard.instantiateViewController(withIdentifier: "PreviousViewController") as! PreviousViewController
        
        // Add View Controller as Child View Controller
        self.add(asChildViewController: viewController)
        
        return viewController
    }()


    // MARK: - View Life Cycle

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }

    // MARK: - View Methods

    private func setupView() {
        setupSegmentedControl()

        updateView()
    }

    private func updateView() {
        if segmentedControl.selectedSegmentIndex == 0 {
            remove(asChildViewController: currentOrderViewController)
            remove(asChildViewController: previousViewController)
            add(asChildViewController: ordersViewController)
        } else  if  segmentedControl.selectedSegmentIndex == 1{
            remove(asChildViewController: ordersViewController)
            remove(asChildViewController: previousViewController)
            add(asChildViewController: currentOrderViewController)
        }else{
           remove(asChildViewController: ordersViewController)
            remove(asChildViewController: currentOrderViewController)
            add(asChildViewController: previousViewController)
        }
    }

    private func setupSegmentedControl() {
        // Configure Segmented Control
        segmentedControl.removeAllSegments()
        
        segmentedControl.insertSegment(withTitle: "كل الطلبات", at: 0, animated: false)
        segmentedControl.insertSegment(withTitle: "الطلبات الحالية", at: 1, animated: false)
        segmentedControl.insertSegment(withTitle: "الطلبات السابقة", at: 2, animated: false)
        segmentedControl.addTarget(self, action: #selector(selectionDidChange(_:)), for: .valueChanged)

        // Select First Segment
        segmentedControl.selectedSegmentIndex = MasterViewController.segmentedControlIndex
        
    }

    // MARK: - Actions

    @objc func selectionDidChange(_ sender: UISegmentedControl) {
        updateView()
    }

    // MARK: - Helper Methods

    private func add(asChildViewController viewController: UIViewController) {
        // Add Child View Controller
        addChildViewController(viewController)

        // Add Child View as Subview
        view.addSubview(viewController.view)

        // Configure Child View
        viewController.view.frame = view.bounds
        viewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]

        // Notify Child View Controller
        viewController.didMove(toParentViewController: self)
    }
    
    private func remove(asChildViewController viewController: UIViewController) {
        // Notify Child View Controller
        viewController.willMove(toParentViewController: nil)

        // Remove Child View From Superview
        viewController.view.removeFromSuperview()

        // Notify Child View Controller
        viewController.removeFromParentViewController()
    }
    
}
