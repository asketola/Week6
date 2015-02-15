//
//  HotelService.h
//  HotelCoreData
//
//  Created by Annemarie Ketola on 2/11/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CoreDataStack.h"
#import "Reservation.h"
#import "Room.h"
#import "Guest.h"

@interface HotelService : NSObject

@property (strong, nonatomic) CoreDataStack *coreDataStack;

+(id)sharedService;
-(instancetype)initForTesting;

// Function to use to make reservations
-(Reservation *)bookreservationForGuest:(Guest *)guest ForRoom:(Room *)room startDate:(NSDate *)startDate endDate:(NSDate *)endDate;

@end
