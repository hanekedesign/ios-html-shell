//
//  HDViewController.m
//  html-shell
//
//  Created by Jesse Curry on 11/24/12.
//  Copyright (c) 2012 Haneke Design. All rights reserved.
//

#import "HDViewController.h"

@interface HDViewController ()
@property (nonatomic, readonly) NSUserDefaults* prefs;
@property (nonatomic, readonly) BOOL longPressToReload;
@property (nonatomic, readonly) BOOL scalesPagesToFit;
@property (nonatomic, readonly) BOOL webViewBounces;
@end

////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation HDViewController
@synthesize webView=_webView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	
	if ( self.longPressToReload )
	{
		UIGestureRecognizer* longPressRecognizer = [[UILongPressGestureRecognizer alloc]
													initWithTarget: self.webView
													action: @selector(reload)];
		[self.webView addGestureRecognizer: longPressRecognizer];
	}
	self.webView.scalesPageToFit = self.scalesPagesToFit;
    self.webView.scrollView.bounces = self.webViewBounces;
	
	NSString* urlString = [NSString stringWithFormat: @"%@:%d", BASE_URL, HTTP_PORT];
	NSURL* url = [NSURL URLWithString: urlString];
	NSURLRequest* urlRequest = [NSURLRequest requestWithURL: url];
	[self.webView loadRequest: urlRequest];
}

#pragma mark -
#pragma mark Private
- (NSUserDefaults*)prefs
{
	return [NSUserDefaults standardUserDefaults];
}

- (BOOL)longPressToReload
{
	BOOL longPressToReload = NO;
	
	longPressToReload = [[self.prefs objectForKey: PREF_LONGPRESS_TO_RELOAD] boolValue];
	
	return longPressToReload;
}

- (BOOL)scalesPagesToFit
{
	BOOL scalesPagesToFit = NO;
	
	scalesPagesToFit = [[self.prefs objectForKey: PREF_SCALES_PAGES_TO_FIT] boolValue];
	
	return scalesPagesToFit;
}

- (BOOL)webViewBounces
{
    BOOL webViewBounces = NO;
    
    webViewBounces = [[self.prefs objectForKey: PREF_WEBVIEW_BOUNCES] boolValue];
    
    return webViewBounces;
}

@end
