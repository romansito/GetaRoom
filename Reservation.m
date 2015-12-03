//
//  Reservation.m
//  GetaRoom
//
//  Created by Roman Salazar Lopez on 11/30/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//
#import "Room.h"
#import "Reservation.h"
#import "NSObject+NSmanagedObjectContext_Category.h"
//@import UIKit;


@implementation Reservation

+ (NSString *)name {
	return @"Reservation";
}

+ (instancetype)reservationWithStartDate:(NSDate *)startDate endDate:(NSDate *)endDate room:(Room *)room {
	
	Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:[self name] inManagedObjectContext:[NSManagedObjectContext managerContext]];
	
	reservation.startDate = startDate;
	reservation.endDate = endDate;
	reservation.room = room;
	
	return reservation;
	
}

@end
