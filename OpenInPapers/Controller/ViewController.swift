//
//  ViewController.swift
//  OpenInPapersExtension
//
//  Created by James Valaitis on 21/07/2014.
//  Copyright (c) 2014 James Valaitis. All rights reserved.
//

import MobileCoreServices
import UIKit
import WebKit

class ViewController: UIViewController
{
	var webView: WKWebView!
	@IBOutlet var proxyWebView: UIView!
	@IBOutlet var searchBar: UISearchBar!
	
	override func loadView()
	{
		super.loadView()
		
		self.webView = WKWebView()
		self.webView.navigationDelegate = self
		self.webView.frame = self.proxyWebView.frame
		self.webView.autoresizingMask = .FlexibleLeftMargin | .FlexibleRightMargin | .FlexibleTopMargin | .FlexibleBottomMargin | .FlexibleWidth | .FlexibleHeight
		self.proxyWebView.addSubview(self.webView)
		self.webView.scrollView.contentInset = UIEdgeInsets(top: self.searchBar.frame.size.height, left: 0.0, bottom: 44.0, right: 0.0)
	}
	
	override func viewDidLoad()
	{
		super.viewDidLoad()
		
		self.loadURL("http://google.com")
		
		println("\(self.webView.frame)")
	}
	
	@IBAction func actionTapped(actionButton: UIBarButtonItem?)
	{
		let activityVC = UIActivityViewController(activityItems: [self.webView.URL], applicationActivities: nil)
		activityVC.completionWithItemsHandler =
		{
			(activityType: String!, completed: Bool, returnedItems: [AnyObject]!, error: NSError!) in
			
			if returnedItems?.count > 0
			{
				if let extensionItem = returnedItems[0] as? NSExtensionItem
				{
					if let itemProvider = extensionItem.attachments[0] as? NSItemProvider
					{
						let itemType = kUTTypeURL as NSString
						
						if itemProvider.hasItemConformingToTypeIdentifier(itemType)
						{
							itemProvider.loadItemForTypeIdentifier(itemType, options: nil, completionHandler:
								{
									(item: NSSecureCoding!, error: NSError!) in
									
									if let url = item as? NSURL!
									{
										self.loadURL(url.absoluteString)
									}
								})
						}
					}
				}
			}
		}
	}

	@IBAction func backTapped(backButton: UIBarButtonItem?)
	{
		self.webView.goBack()
	}
	
	@IBAction func forwardTapped(forwardButton: UIBarButtonItem?)
	{
		self.webView.goForward()
	}
	
	@IBAction func refreshTapped(refreshButton: UIBarButtonItem?)
	{
		self.webView.reload()
	}
	
	func loadURL(urlString: String)
	{
		let url = NSURL(string: urlString)
		let request = NSURLRequest(URL: url)
		self.webView.loadRequest(request)
	}
}

extension ViewController : WKNavigationDelegate
{
	func webView(webView: WKWebView!, didCommitNavigation navigation: WKNavigation!)
	{
		
	}
	
	func webView(webView: WKWebView!, didFailNavigation navigation: WKNavigation!, withError error: NSError!)
	{
		
	}
	
	func webView(webView: WKWebView!, didFailProvisionalNavigation navigation: WKNavigation!, withError error: NSError!)
	{
		
	}
	
	func webView(webView: WKWebView!, didFinishNavigation navigation: WKNavigation!)
	{
		
	}
}

extension ViewController: UISearchBarDelegate
{
	func searchBar(searchBar: UISearchBar!, textDidChange searchText: String!)
	{
		
	}
	
	func searchBarSearchButtonClicked(searchBar: UISearchBar!)
	{
		self.loadURL(searchBar.text)
	}
}