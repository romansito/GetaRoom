//
//  Guest.h
//  GetaRoom
//
//  Created by Roman Salazar Lopez on 11/30/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreData/CoreData.h>
//#import "Guest+CoreDataProperties.h"


@class Reservation;

NS_ASSUME_NONNULL_BEGIN

@interface Guest : NSManagedObject

+ (instancetype)guestWithName:(NSString *)name;

@end

NS_ASSUME_NONNULL_END

#import "Guest+CoreDataProperties.h"