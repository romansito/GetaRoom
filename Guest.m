//
//  Guest.m
//  GetaRoom
//
//  Created by Roman Salazar Lopez on 11/30/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

#import "Guest.h"
#import "Reservation.h"
#import "NSObject+NSmanagedObjectContext_Category.h"
#import "AppDelegate.h"

@implementation Guest

+ (instancetype)guestWithName:(NSString *)name {
	
	AppDelegate *delegate = (AppDelegate *)[[UIApplication sharedApplication]delegate];
	
	
	Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:delegate.managedObjectContext];
	
	guest.firstName = name;
	guest.lastName = name;
	
	return guest;
}

@end