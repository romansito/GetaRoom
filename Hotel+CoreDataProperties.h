//
//  Hotel+CoreDataProperties.h
//  GetaRoom
//
//  Created by Roman Salazar Lopez on 11/30/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Hotel.h"

NS_ASSUME_NONNULL_BEGIN

@interface Hotel (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSNumber *stars;
@property (nullable, nonatomic, retain) NSNumber *location;
@property (nullable, nonatomic, retain) NSSet<NSManagedObject *> *room;

@end

@interface Hotel (CoreDataGeneratedAccessors)

- (void)addRoomObject:(NSManagedObject *)value;
- (void)removeRoomObject:(NSManagedObject *)value;
- (void)addRoom:(NSSet<NSManagedObject *> *)values;
- (void)removeRoom:(NSSet<NSManagedObject *> *)values;

@end

NS_ASSUME_NONNULL_END
