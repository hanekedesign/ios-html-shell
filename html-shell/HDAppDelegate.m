//
//  HDAppDelegate.m
//  html-shell
//
//  Created by Jesse Curry on 11/24/12.
//  Copyright (c) 2012 Haneke Design. All rights reserved.
//

#import "HDAppDelegate.h"

//
#import "DDLog.h"
#import "DDTTYLogger.h"
#import "HTTPServer.h"

// View Controllers
#import "HDViewController.h"

#if DEBUG
static const int ddLogLevel = LOG_LEVEL_VERBOSE;
#else
static const int ddLogLevel = LOG_LEVEL_OFF;
#endif

@interface HDAppDelegate ()
- (void)loadDefaultSettings;
@property (nonatomic, strong) HTTPServer* httpServer;
- (void)startHTTPServer;
- (void)stopHTTPServer;
@end

////////////////////////////////////////////////////////////////////////////////////////////////////
@implementation HDAppDelegate
@synthesize httpServer=_httpServer;

- (BOOL)application: (UIApplication*)application didFinishLaunchingWithOptions: (NSDictionary*)launchOptions
{
#if DEBUG
	[DDLog addLogger: [DDTTYLogger sharedInstance]];
#endif
	[self loadDefaultSettings];
	[self startHTTPServer];
	
	////////////////////////////////////////////////////////////////////////////////////////////////
    self.window = [[UIWindow alloc] initWithFrame: [[UIScreen mainScreen] bounds]];

    if ( [[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone )
    {
        self.viewController = [[HDViewController alloc] initWithNibName: @"HDViewController_iPhone" bundle: nil];
    }
    else
    {
        self.viewController = [[HDViewController alloc] initWithNibName: @"HDViewController_iPad" bundle: nil];
    }
    self.window.rootViewController = self.viewController;
    [self.window makeKeyAndVisible];
	
    return YES;
}

- (void)applicationWillResignActive: (UIApplication*)application
{
}

- (void)applicationDidEnterBackground: (UIApplication*)application
{
	[self stopHTTPServer];
}

- (void)applicationWillEnterForeground: (UIApplication*)application
{

}

- (void)applicationDidBecomeActive: (UIApplication*)application
{
	[self startHTTPServer];
}

- (void)applicationWillTerminate: (UIApplication*)application
{
	[self stopHTTPServer];
}

#pragma mark -
#pragma mark Private
- (void)loadDefaultSettings
{
	NSString* defaultsFilePath = [[NSBundle mainBundle] pathForResource: @"Settings"
                                                                 ofType: @"plist"];
	NSDictionary* defaultsDict = [NSDictionary dictionaryWithContentsOfFile: defaultsFilePath];
	
	if ( defaultsDict )
		[[NSUserDefaults standardUserDefaults] registerDefaults: defaultsDict];
}

#pragma mark -
- (HTTPServer*)httpServer
{
	if ( _httpServer == nil )
	{
		NSString* documentRoot = [[[NSBundle mainBundle] resourcePath]
								  stringByAppendingPathComponent: @"webRoot"];
		
		// Create server.
		_httpServer = [[HTTPServer alloc] init];
		_httpServer.documentRoot = documentRoot;
		_httpServer.port = HTTP_PORT;
	}
	
	return _httpServer;
}

- (void)startHTTPServer
{
	if ( !self.httpServer.isRunning )
	{
		NSError* error = nil;
		
		if ( ![self.httpServer start: &error] )
		{
			UIAlertView* errorAlertView = [[UIAlertView alloc]
										   initWithTitle: NSLocalizedString(@"Error", @"")
										   message: NSLocalizedString(@"There was a problem starting the server.", @"")
										   delegate: nil
										   cancelButtonTitle: NSLocalizedString(@"OK", @"")
										   otherButtonTitles: nil];
			[errorAlertView show];
		}
		else
		{
			
		}
	}
}

- (void)stopHTTPServer
{
	[self.httpServer stop];
}

@end
