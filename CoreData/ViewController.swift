//
//  ViewController.swift
//  CoreData
//
//  Created by Tvo001 on 2/18/16.
//  Copyright © 2016 Tvo001. All rights reserved.
//

import UIKit
import CoreData


class ViewController: UIViewController,UITableViewDataSource,UITableViewDelegate,PKDownloadButtonDelegate
{

    @IBOutlet weak var downloadButton: LoadingButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var webView: UIWebView!
    
    var names = [String]()

    var people = [NSManagedObject]()

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        title = "\"The List\""
        tableView.registerClass(UITableViewCell.self,
            forCellReuseIdentifier: "Cell")
        
        self.loadWebView()
     
        
        let button   = UIButton(type: UIButtonType.System) as UIButton
        button.frame = CGRectMake(100, 100, 100, 50)
        button.backgroundColor = UIColor.greenColor()
        button.setTitle("Test Button", forState: UIControlState.Normal)
        button.addTarget(self, action: "buttonAction:", forControlEvents: UIControlEvents.TouchUpInside)
        
        
        let loadingView = UIActivityIndicatorView.init(activityIndicatorStyle:UIActivityIndicatorViewStyle.Gray) as UIActivityIndicatorView
        loadingView.center = self.view.center
        self.view.addSubview(loadingView)
        loadingView.startAnimating()

        
        
        let switchStatus = true
        
        
            switch switchStatus
            {
            case true:
                print("true")
            case false:
                print("false")
                   }
        
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        print("view will appear")
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let fetchRequest = NSFetchRequest(entityName: "Person")
        
        //3
        do {
            let results =
            try managedContext.executeFetchRequest(fetchRequest)
            people = results as! [NSManagedObject]
        } catch let error as NSError {
            print("Could not fetch \(error), \(error.userInfo)")
        }
    }
    
    func downloadButtonTapped(downloadButton: PKDownloadButton!, currentState state: PKDownloadButtonState) {
        
        
        switch state.hashValue
        {
        case 0:
            print("kPKDownloadButtonState_Pending")
            
            break;
        case 1:
            print("kPKDownloadButtonState_StartDownload")
        break;
            
        default:
            print("default")
            
            break;
    }
        

    }
    
    @IBAction func downloadClick(sender: LoadingButton) {
        
        print("download click")
        
        sender.startDowloading()

        
    }
    
    
    @IBAction func stopDownload(sender: AnyObject) {
        
        print("stop download")
        
        self.downloadButton.stopDownloading()
        
    }
    
    // MARK: Test request url
    func loadWebView()
    {
        let url = NSURL (string: "http://www.24h.com.vn/")
        let request = NSURLRequest (URL: url!)
        webView.loadRequest(request)
        
        
    }
    
    
    // MARK: UITableViewDataSource
    func tableView(tableView: UITableView,
        numberOfRowsInSection section: Int) -> Int {
            return people.count
    }
    
    func tableView(tableView: UITableView,
        cellForRowAtIndexPath
        indexPath: NSIndexPath) -> UITableViewCell {
            
            let cell =
            tableView.dequeueReusableCellWithIdentifier("Cell")
            
            let person = people[indexPath.row]
            
            cell!.textLabel!.text =
                person.valueForKey("name") as? String
            
            return cell!
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func saveName(name: String) {
        //1
        let appDelegate =
        UIApplication.sharedApplication().delegate as! AppDelegate
        
        let managedContext = appDelegate.managedObjectContext
        
        //2
        let entity =  NSEntityDescription.entityForName("Person",
            inManagedObjectContext:managedContext)
        
        let person = NSManagedObject(entity: entity!,
            insertIntoManagedObjectContext: managedContext)
        
        //3
        person.setValue(name, forKey: "name")
        
        //4
        do {
            try managedContext.save()
            //5
            people.append(person)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    //Implement the addName IBAction
    @IBAction func addButtonClick(sender: AnyObject) {
        
        let alert = UIAlertController(title: "New Name",
            message: "Add a new name",
            preferredStyle: .Alert)
        
        let saveAction = UIAlertAction(title: "Save",
            style: .Default,
            handler: { (action:UIAlertAction) -> Void in
                let textField = alert.textFields!.first
                self.saveName(textField!.text!)
                self.tableView.reloadData()

        })
        
        let cancelAction = UIAlertAction(title: "Cancel",
            style: .Default) { (action: UIAlertAction) -> Void in
        }
        
        alert.addTextFieldWithConfigurationHandler {
            (textField: UITextField) -> Void in
        }
        
        alert.addAction(saveAction)
        alert.addAction(cancelAction)
        
        presentViewController(alert,
            animated: true,
            completion: nil)
        
    }

}








