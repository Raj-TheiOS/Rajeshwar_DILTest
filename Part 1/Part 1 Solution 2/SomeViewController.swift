//
//  ViewController.swift
//  DilTestPartOne
//
//  Created by Raj Rathod on 10/10/23.
//

import UIKit

// MARK: Use Meaningful Variable and Function Names:
/// Try to use more descriptive variable and function names. For example, instead of someVC, use a more meaningful name that reflects the purpose of the view controller.
///
// MARK: Grouped related code into functions for better organization and readability.:
/// Created an extension for SomeViewController to conform to UICollectionViewDelegate, UICollectionViewDataSource, and UICollectionViewDelegateFlowLayout.
/// applied incase of setupCollectionView(), setupNavigationBar(), fetchData()
///
// MARK: Spacing in Function Definitions:
/// Use line breaks to separate functions and methods.
/// Use a blank line before and after a function declaration for better organization
///
// MARK: Comments and Documentation:
///  Add comments to your code to explain its purpose and how it works. Documentation can help you and others understand the code better.

class SomeViewController: UIViewController {
    
    @IBOutlet weak var collectionViewTopConstraint: NSLayoutConstraint!
    @IBOutlet var detailViewWidthConstraint: NSLayoutConstraint!
    @IBOutlet var collectionView: UICollectionView!
    @IBOutlet var detailView: UIView!

    var datasource = GenericCollectionDataSource()
    var detailVC: UIViewController?
    var dataArray: [Any]? {
        didSet {
            collectionView.reloadData()
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectionView()
        setupNavigationBar()
        fetchData()
    }

    private func setupCollectionView() {
        datasource.identifier = "SomeCell"
        collectionView.dataSource = datasource
        collectionView.delegate = datasource
        
        datasource.sizeItem = CGSize.init(width: (self.collectionView.frame.width/2)-5, height: (self.collectionView.frame.width/2))
        datasource.didSelect = { cell, index  in
            self.showDetail()
        }
    }

    private func setupNavigationBar() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: NSLocalizedString("Done", comment: ""), style: .plain, target: self, action: #selector(dismissController))
    }

    @objc func dismissController() {
        // Handle dismissal logic here
    }
    
    @IBAction func closeshowDetails () {
        detail(willShow: false)
    }
    
    @IBAction func showDetail () {
        detail(willShow: true)
    }

    // MARK: Code Duplication:
    /// The methods closeshowDetails and showDetail seem to have duplicated code. Consider refactoring them into a single function with a parameter to specify the width.
    ///
    // MARK: Reuse Code:
    /// It appears that you have duplicated the same code at the beginning and end of your code. You only need this code once.
    ///
    func detail(willShow: Bool) {
        
        self.detailViewWidthConstraint.constant = willShow ? 100: 0
        
        UIView.animate(withDuration: 0.5, animations: {
            self.view.layoutIfNeeded()
        }) { (completed) in
            if willShow {
                self.view.addSubview(self.detailView)
            } else {
                self.detailVC?.removeFromParent()
            }
        }

    }
    
    // MARK: Error Handling:
    /// Add proper error handling for your network request. Check for errors and handle them gracefully instead of ignoring them.

    // encapsulate common networking functionality in a reusable and testable way. It provides a central point for making network requests and handling responses. By using a singleton pattern, you can ensure that there's only one instance of the NetworkManager throughout your application.
    /// placing this in view model is good idea incase of mvvm in caase iper in interactor aand presenter
    func fetchData() {
        guard let url = URL(string: "testreq") else { return }

        NetworkManager.shared.fetchData(from: url) { [weak self] (dataArray, error) in
            guard let self = self else { return }

            if let error = error {
                // Handle the error
                print("Error: \(error)")
            } else if let dataArray = dataArray {
                // Update the UI or process the received data
                self.dataArray = dataArray
            }
        }
    }

}

// MARK: Code Organization:
/// Organize your code into logical sections with comments or extensions to make it more readable and maintainable.
///
// MARK: Spacing After Commas:
/// Use a space after commas in function parameters, arrays, and dictionaries.
/// Example: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout
///
extension SomeViewController {
    // MARK:- Setting up Cell
    func setupCollectionCell(dataArray: [Any]) {
        datasource.array = dataArray
        datasource.configure = {cell, index in
            // Configure cell from here
        }
    }
}
