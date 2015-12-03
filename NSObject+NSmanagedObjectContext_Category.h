//
//  NSObject+NSmanagedObjectContext_Category.h
//  GetaRoom
//
//  Created by Roman Salazar Lopez on 12/2/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

#import <Foundation/Foundation.h>
@import CoreData;

@interface NSObject (NSmanagedObjectContext_Category)
+ (NSManagedObjectContext*)managerContext;
@end
