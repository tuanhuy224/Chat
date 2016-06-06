//
//  LeftMenuViewController.swift
//  Chat
//
//  Created by DaiVP on 6/1/16.
//
//

import UIKit

class LeftMenuViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    var dataList:[String] = [
        "Account",
        "Settings",
        "Sign out"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.delegate = self
      
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension LeftMenuViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataList.count + 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        var cell:UITableViewCell!
        if indexPath.row == 0 {
            cell = tableView.dequeueReusableCellWithIdentifier("accountImageCell", forIndexPath: indexPath)
            
        } else {
            cell = tableView.dequeueReusableCellWithIdentifier("settingCell", forIndexPath: indexPath)
            cell.textLabel?.text = dataList[indexPath.row - 1]
        }
        return cell
    }
}

extension LeftMenuViewController: UITableViewDelegate {
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 3 {
            self.slideMenuController()?.closeLeft()
            let loginVC = self.storyboard?.instantiateViewControllerWithIdentifier("LoginID") as! LoginViewController
            self.presentViewController(loginVC, animated: true, completion: nil)
        }
    }
}
