//
//  BookRoomViewController.h
//  GetaRoom
//
//  Created by Roman Salazar Lopez on 12/2/15.
//  Copyright © 2015 Roman Salazar Lopez. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"
#import "Hotel.h"
#import "Reservation.h"
#import "Guest.h"

@interface BookRoomViewController : UIViewController
@property (strong,nonatomic)Room *room;
@property (strong,nonatomic)NSDate *startDate;
@property (strong,nonatomic)NSDate *endDate;
@end
