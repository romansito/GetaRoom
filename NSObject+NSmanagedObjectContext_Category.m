//
//  NSObject+NSmanagedObjectContext_Category.m
//  GetaRoom
//
//  Created by Roman Salazar Lopez on 12/2/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

#import "NSObject+NSmanagedObjectContext_Category.h"
#import "AppDelegate.h"

@implementation NSObject (NSmanagedObjectContext_Category)
+ (NSManagedObjectContext *)managerContext {
	
	AppDelegate *delegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
	
	return  delegate.managedObjectContext;
	
}
@end

