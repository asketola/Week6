//
//  AddReservationViewController.h
//  HotelCoreData
//
//  Created by Annemarie Ketola on 2/10/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

#import "ViewController.h"
#import <UIKit/UIKit.h>
#import "Room.h"

@interface AddReservationViewController : ViewController
@property (strong, nonatomic) Room *selectedRoom;

@end
