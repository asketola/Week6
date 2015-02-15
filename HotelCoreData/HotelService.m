//
//  HotelService.m
//  HotelCoreData
//
//  Created by Annemarie Ketola on 2/11/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

#import "HotelService.h"

@implementation HotelService

// ******************* Makes the Hotel Servies singleton  *******************
+(id)sharedService {
  static HotelService *mySharedService = nil;
  static dispatch_once_t onceToken;                                      // A predicate for use with the dispatch_once function
  dispatch_once(&onceToken, ^{
    mySharedService = [[self alloc] init];
  });
  return mySharedService;
}

// ******************* Initiates it with Core Data  *******************
-(instancetype)init {
  self = [super init];
  if (self) {
    self.coreDataStack = [[CoreDataStack alloc] init];
    [self.coreDataStack seedDataBaseIfNeeded];
  }
  return self;
}

// ******************* Initiates it with Core Data for testing  *******************
-(instancetype)initForTesting {
  self = [self init];
  if (self) {
    self.coreDataStack = [[CoreDataStack alloc] initForTesting];
  }
  return self;
}

// ******************* Reservation function *******************
-(Reservation *)bookreservationForGuest:(Guest *)guest ForRoom:(Room *)room startDate:(NSDate *)startDate endDate:(NSDate *)endDate {
  Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.coreDataStack.managedObjectContext];
// sets up all the reservation properties
  reservation.startDate = startDate;
  reservation.endDate = endDate;
  reservation.room = room;
  reservation.guest = guest;
  
// sets up the error variable to check to see if a reservation was made
  NSError *saveError;
  [self.coreDataStack.managedObjectContext save:&saveError];
  if (!saveError) {                                                    // if no error, then return a resevation
    return reservation;
  } else {
    return nil;
  }
}

@end
