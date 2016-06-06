//
//  ChatDetailViewController.swift
//  Chat
//
//  Created by DaiVP on 6/1/16.
//
//

import UIKit

class ChatDetailViewController: UIViewController {

    @IBOutlet weak var bottomConstraintChatComposeView: NSLayoutConstraint!
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var chatComposeView: UIView!
    
    @IBOutlet weak var messageTextField: UITextField!
    var messageList:[String] = [
        "hi",
        "hello",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Ut quis.",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Curabitur dictum sit amet tellus ac ornare. Nullam a iaculis sem. Sed.",
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Phasellus neque dui, congue in condimentum a, sodales nec massa. Nam quis pharetra felis. Etiam leo leo, interdum ac convallis at, viverra sit amet ex. Sed iaculis, leo aliquam faucibus imperdiet, dolor sem lobortis turpis, non dapibus enim diam non velit. Morbi.",
        "Lorem ipsum dolor sit amet.",
        "byer"
    ]
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension
        
        self.messageTextField.delegate = self
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(willShowKeyBoard(_:)), name: UIKeyboardWillShowNotification, object: nil)
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(willHideKeyBoard(_:)), name: UIKeyboardWillHideNotification, object: nil)
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let indexPath:NSIndexPath = NSIndexPath(forRow: self.messageList.count - 1, inSection: 0)
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @objc func willShowKeyBoard(notification : NSNotification){
        let userInfo:NSDictionary = notification.userInfo!
        var duration : NSTimeInterval = 0
        duration = userInfo[UIKeyboardAnimationDurationUserInfoKey] as! NSTimeInterval
        let keyboardFrame = (userInfo.objectForKey(UIKeyboardFrameEndUserInfoKey) as! NSValue).CGRectValue()
        
        UIView.animateWithDuration(duration, delay: 0, options: [], animations: {
                self.bottomConstraintChatComposeView.constant = keyboardFrame.height
                self.tableView.frame = CGRectMake(0, 0, self.tableView.frame.width, self.tableView.frame.height - keyboardFrame.height)
            }, completion: nil)
        let indexPath:NSIndexPath = NSIndexPath(forRow: self.messageList.count - 1, inSection: 0)
        self.tableView.scrollToRowAtIndexPath(indexPath, atScrollPosition: .Bottom, animated: true)
    }
    
    func willHideKeyBoard(notification : NSNotification){
        self.bottomConstraintChatComposeView.constant = 0
        self.tableView.frame = CGRectMake(0, 0, self.tableView.frame.width, self.tableView.frame.height)
    }
    
}

extension ChatDetailViewController: UITextFieldDelegate {
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
}

extension ChatDetailViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageList.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cellIdentifier:String = (indexPath.row % 2 ) == 0 ? "leftCell" : "rightCell"
        let cell = tableView.dequeueReusableCellWithIdentifier(cellIdentifier, forIndexPath: indexPath)
        var message:UILabel!
        if indexPath.row % 2 == 0 {
            message = cell.viewWithTag(100) as! UILabel
        } else {
            message = cell.viewWithTag(200) as! UILabel
        }
        message.text = messageList[indexPath.row]
        return cell
    }
}
