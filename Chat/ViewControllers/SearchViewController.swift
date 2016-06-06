//
//  SearchViewController.swift
//  Chat
//
//  Created by DaiVP on 6/1/16.
//
//

import UIKit
import Firebase

class SearchViewController: UIViewController {

    let refRoot = FIRDatabase.database().reference()
    @IBOutlet weak var tableView: UITableView!
    var searchBar:UISearchBar = UISearchBar(frame: CGRect(x: 0, y: 0, width: 200, height: 20))
    override func viewDidLoad() {
        super.viewDidLoad()
        setupSearchBar()
        refRoot.child("user")
        
    }
    
    func setupSearchBar() {
        searchBar.placeholder = "Search everything..."
        searchBar.delegate = self
        searchBar.becomeFirstResponder()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: searchBar)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func cancelSearch(sender: AnyObject) {
//        self.navigationController?.popViewControllerAnimated(true)
        refRoot.observeSingleEventOfType(.Value, withBlock: { (snapshot) in
            print(snapshot.value!)
        })
    }
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        guard let stringSearch = searchBar.text else {return}
        print(stringSearch)
        searchBar.resignFirstResponder()
    }
}
