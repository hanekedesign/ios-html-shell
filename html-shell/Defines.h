//
//  Defines.h
//  html-shell
//
//  Created by Jesse Curry on 11/24/12.
//  Copyright (c) 2012 Haneke Design. All rights reserved.
//

#if TARGET_IPHONE_SIMULATOR
#define BASE_URL	@"http://localhost"
#define	HTTP_PORT	8080
#else
#define BASE_URL	@"http://localhost"
#define	HTTP_PORT	80
#endif

#define	PREF_LONGPRESS_TO_RELOAD	@"HTMLShell_LongPressToReload"
#define PREF_SCALES_PAGES_TO_FIT	@"HTMLShell_ScalesPagesToFit"
#define PREF_WEBVIEW_BOUNCES        @"HTMLShell_WebViewBounces"