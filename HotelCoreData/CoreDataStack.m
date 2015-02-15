//
//  CoreDataStack.m
//  HotelCoreData
//
//  Created by Annemarie Ketola on 2/11/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

#import "CoreDataStack.h"
#import "Hotel.h"
#import "Room.h"

@interface CoreDataStack()

@property (nonatomic) BOOL isTesting;

@end

@implementation CoreDataStack
#pragma mark - Core Data Stack


@synthesize managedObjectContext = _managedObjectContext;
@synthesize managedObjectModel = _managedObjectModel;
@synthesize persistentStoreCoordinator = _persistentStoreCoordinator;

-(instancetype)initForTesting {
  self = [super init];
  if (self) {
    self.isTesting = true;
  }
  return self;
}

// ******************* Seeds the database to start off with *******************
-(void)seedDataBaseIfNeeded {
  
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Hotel"];
  NSError *fetchError;
  
  NSInteger results = [self.managedObjectContext countForFetchRequest:fetchRequest error:&fetchError];
  NSLog(@" %ld", (long)results);
  if (results == 0) {
    NSURL *seedURL = [[NSBundle mainBundle] URLForResource:@"seed" withExtension:@"json"];  // Where the file is
    NSData *seedData = [[NSData alloc] initWithContentsOfURL:seedURL];        // Initialize the seedData dataa
    NSError *jsonError;                                                       // Defines the error variable
    NSDictionary *rootDictionary = [NSJSONSerialization JSONObjectWithData:seedData options:0 error:&jsonError];  // Makes a dictionary from the seed data
    if (!jsonError) {
      NSArray *jsonArray = rootDictionary[@"Hotels"]; // if no errors, then put in hotel
      
// json parsing code for hotel class variables
      for (NSDictionary *hotelDictionary in jsonArray) {
        Hotel *hotel = [NSEntityDescription insertNewObjectForEntityForName:@"Hotel" inManagedObjectContext:self.managedObjectContext];
        hotel.name = hotelDictionary[@"name"];
        hotel.rating = hotelDictionary[@"stars"];
        hotel.location = hotelDictionary[@"location"];
        
// json parsing code for room class variables
        NSArray *roomsArray = hotelDictionary[@"rooms"];
        for (NSDictionary *roomDictionary in roomsArray) {
          Room *room = [NSEntityDescription insertNewObjectForEntityForName:@"Room" inManagedObjectContext:self.managedObjectContext];
          room.number = roomDictionary[@"number"];
          room.beds = roomDictionary[@"beds"];
          room.rate = roomDictionary[@"rate"];
          room.hotel = hotel;
        }
      }
      
      NSError *saveError;
      [self.managedObjectContext save:&saveError];
      
      if (saveError) {
        NSLog(@"%@", saveError.localizedDescription);
      }
    }
  }
}

- (NSURL *)applcationDocumentsDirectory {
  return [[[NSFileManager defaultManager] URLsForDirectory:NSDocumentationDirectory inDomains:NSUserDomainMask] lastObject];
}

// ******************* <amagedObjectModel setup *******************
- (NSManagedObjectModel *)managedObjectModel {
  
  if (_managedObjectModel != nil) {
    return _managedObjectModel;
  }
  NSURL *modelURL = [[NSBundle mainBundle] URLForResource:@"HotelCoreData" withExtension:@"momd"];
  _managedObjectModel = [[NSManagedObjectModel alloc] initWithContentsOfURL:modelURL];
  return _managedObjectModel;
}

// ******************* peristent Store Coordinator *******************
- (NSPersistentStoreCoordinator *)persistentStoreCoordinator {
  if (_persistentStoreCoordinator != nil) {
    return _persistentStoreCoordinator;
  }
  
  _persistentStoreCoordinator = [[NSPersistentStoreCoordinator alloc] initWithManagedObjectModel:[self managedObjectModel]];
  NSURL *storeURL = [[self applcationDocumentsDirectory] URLByAppendingPathComponent:@"HotelCoreData.sqlite"];
  NSError *error = nil;
  NSString *failureReason = @"There was an error creating or loading the application's saved data.";
  NSString *storeType;
  if (self.isTesting) {
    storeType = NSInMemoryStoreType;
  } else {
    storeType = NSSQLiteStoreType;
  }
  NSDictionary *options = @{NSMigratePersistentStoresAutomaticallyOption : @true, NSInferMappingModelAutomaticallyOption : @true, NSPersistentStoreUbiquitousContentNameKey : @"HotelCoreData"};
  
  if (![_persistentStoreCoordinator addPersistentStoreWithType:storeType configuration:nil URL:storeURL options:options error:&error]) {
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSLocalizedDescriptionKey] = @"Failed to initilizer the application's saved data";
    dict[NSLocalizedFailureReasonErrorKey] = failureReason;
    dict[NSUnderlyingErrorKey] = error;
    error = [NSError errorWithDomain:@"YOUR_ERROR_DOMAIN" code:9999 userInfo:dict];
    NSLog(@"Unresolved srror %@, %@", error, [error userInfo]);
    abort();
  }
  return _persistentStoreCoordinator;
}

// ******************* managed Object context *******************
- (NSManagedObjectContext *)managedObjectContext {
  if (_managedObjectContext != nil) {
    return _managedObjectContext;
  }
  
  NSPersistentStoreCoordinator *coordinator = [self persistentStoreCoordinator];
  if (!coordinator) {
    return nil;
  }
  _managedObjectContext = [[NSManagedObjectContext alloc] init];
  [_managedObjectContext setPersistentStoreCoordinator:coordinator];
  return _managedObjectContext;
}

#pragma mark - Core Data Saving support

// ******************* Save function *******************
- (void)saveContext {
  NSManagedObjectContext *managedObjectContext = self.managedObjectContext;
  if (managedObjectContext != nil) {
    NSError *error = nil;
    if ([managedObjectContext hasChanges] && ![managedObjectContext save:&error]) {
      NSLog(@"Unresloved error %@, %@", error, [error userInfo]);
      abort();
    }
  }
}

@end
