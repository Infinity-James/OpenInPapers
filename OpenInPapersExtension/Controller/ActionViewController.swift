//
//  ActionViewController.swift
//  OpenInPapersExtension
//
//  Created by James Valaitis on 28/07/2014.
//  Copyright (c) 2014 James Valaitis. All rights reserved.
//

import MobileCoreServices
import UIKit
import WebKit

class ActionViewController: UIViewController
{
	var webView: WKWebView!
	var url: NSURL!
	@IBOutlet var webViewContainerView: UIView!
	
	override func loadView()
	{
		self.webView = WKWebView()
		self.webView.frame = self.webViewContainerView.frame
		self.webView.autoresizingMask = .FlexibleLeftMargin | .FlexibleRightMargin | .FlexibleTopMargin | .FlexibleBottomMargin | .FlexibleWidth | .FlexibleHeight
		self.webViewContainerView.addSubview(self.webView)
		self.webView.scrollView.contentInset = UIEdgeInsets(top: self.topLayoutGuide.length, left: 0.0, bottom: 0.0, right: 0.0)
	}
	
    override func viewDidLoad() {
        super.viewDidLoad()
    
		var urlFound = false
		
		for item: AnyObject in self.extensionContext.inputItems!
		{
			let inputItem = item as NSExtensionItem
			for provider: AnyObject in inputItem.attachments!
			{
				var activityType = kUTTypeURL as NSString
				
				let itemProvider = provider as NSItemProvider
				if itemProvider.hasItemConformingToTypeIdentifier(activityType)
				{
					itemProvider.loadItemForTypeIdentifier(activityType, options: nil, completionHandler:
					{
						(url, error) in
						
						if url
						{
							self.url = url as NSURL
						}
					})
					
					urlFound = true
					break
				}
			}
			
			if (urlFound)
			{
				self.webView.loadRequest(NSURLRequest(URL: self.url))
				break
			}
		}
    }

    @IBAction func done()
	{
        self.extensionContext.completeRequestReturningItems(self.extensionContext.inputItems, completionHandler: nil)
    }

}
