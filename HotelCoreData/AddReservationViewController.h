//
//  AddReservationViewController.h
//  HotelCoreData
//
//  Created by Annemarie Ketola on 2/10/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Room.h"

@interface AddReservationViewController : UIViewController
@property (strong, nonatomic) Room *selectedRoom;                            // <- variable that was passed from the RoomsViewController

@end
