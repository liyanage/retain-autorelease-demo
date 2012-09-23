//
//  AppDelegate.m
//  RetainAutoreleaseTester
//
//  Created by Marc Liyanage on 9/23/12.
//
//

#import "AppDelegate.h"

@implementation AppDelegate

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification
{
	for (NSInteger i = 0; i < 8; i++) {
		dispatch_async(dispatch_get_global_queue(0, 0), ^{
			[self doSomething];
		});
	}
}

- (void)doSomething
{
	for (NSInteger i = 0; i < 10000; i++) {
		NSMutableArray *ary = [self array];
		NSNumber *number = [ary lastObject];
		NSLog(@"ary %ld %@ %ld", i, ary, [number integerValue]);
		number = [[NSNumber alloc] initWithInteger:0];
		ary = [[NSMutableArray alloc] initWithObjects:number, nil];
		[number release];
		[self setArray:ary];
		[ary release];
	}
}

- (NSMutableArray *)array
{
#if 1
	return [[_array retain] autorelease];
#else
	id value = nil;
	@synchronized(self) {
		value = [_array retain];
	}
	return [value autorelease];
#endif
}

- (void)setArray:(NSMutableArray *)array
{
	if (array != _array) {
		@synchronized(self) {
			id oldArray = _array;
			_array = [array retain];
			[oldArray release];
		}
	}
}


@end
