//
//  AppDelegate.h
//  RetainAutoreleaseTester
//
//  Created by Marc Liyanage on 9/23/12.
//
//

#import <Cocoa/Cocoa.h>

@interface AppDelegate : NSObject <NSApplicationDelegate> {
	NSMutableArray *_array;
}

@property (assign) IBOutlet NSWindow *window;

@end
