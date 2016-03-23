//
//  LoadingButton.swift
//  CoreDataExample
//
//  Created by Tvo001 on 3/23/16.
//  Copyright © 2016 Tvo001. All rights reserved.
//

import Foundation



class LoadingButton: UIButton {
    
    var  loadingView:UIActivityIndicatorView!
    
    
     override func awakeFromNib() {
        
//        self.layer.borderWidth = 1
//        self.layer.borderColor = UIColor.blueColor().CGColor
//        self.layer.cornerRadius = 3
        
    }
    
    func startDowloading()
    {
        self.setTitle("", forState: UIControlState.Normal)
        loadingView = UIActivityIndicatorView.init(activityIndicatorStyle:UIActivityIndicatorViewStyle.Gray) as UIActivityIndicatorView
         loadingView.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2)
        loadingView.color = UIColor.redColor()
        self.addSubview(loadingView)
        loadingView.startAnimating()

    }
    
    func stopDownloading()
    {
        loadingView.stopAnimating()
        loadingView.hidesWhenStopped = true
        self.setTitle("Delete", forState: UIControlState.Normal)
        
    }
}