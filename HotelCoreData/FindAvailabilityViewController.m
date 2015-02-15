//
//  FindAvailabilityViewController.m
//  HotelCoreData
//
//  Created by Annemarie Ketola on 2/10/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

#import "FindAvailabilityViewController.h"
#import "AppDelegate.h"
#import "Reservation.h"
#import "HotelService.h"
#import "ShowAvailabilityViewController.h"
#import "Room.h"

@interface FindAvailabilityViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *hotelsSegmentedButtonPressed;
@property (weak, nonatomic) IBOutlet UIDatePicker *checkinDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *checkoutDatePicker;
// @property (weak, nonatomic) IBOutlet UILabel *dateErrorLabel;
@property (strong, nonatomic) NSArray *finalResults;
// @property (strong, nonatomic) NSManagedObjectContext *context;

@end

@implementation FindAvailabilityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//  self.context = appDelegate.managedObjectContext;
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)findAvailibilityButtonPressed:(id)sender {
  
// ******************* 1st rooms fetch with Core Data  *******************
  NSFetchRequest *fetchRoomRequest = [[NSFetchRequest alloc] initWithEntityName:@"Room"];   // <- initializes the fetch request
  NSString *selectedHotel = [self.hotelsSegmentedButtonPressed titleForSegmentAtIndex:self.hotelsSegmentedButtonPressed.selectedSegmentIndex]; // gets the hotel name from the segment bar
//  NSLog(@"selectedHotel: %@", selectedHotel);
  NSPredicate *roomPredicate = [NSPredicate predicateWithFormat:@"self.hotel.name MATCHES %@", selectedHotel]; // Defines the predicate conditions
  fetchRoomRequest.predicate = roomPredicate;                                              // puts together the fetch and the conditions predicate
  NSLog(@"roomPredicate %@", roomPredicate);
  
// ******************* Reservation fetch with Core Data  *******************
  NSFetchRequest *reservationsFetch = [NSFetchRequest fetchRequestWithEntityName:@"Reservation"];  // sets up the fetch request
  NSPredicate *reservationPredicate = [NSPredicate predicateWithFormat:@"room.hotel.name MATCHES %@ AND startDate <= %@ AND endDate >= %@", selectedHotel, self.checkoutDatePicker.date, self.checkinDatePicker.date];              // Defines the predicate conditions
  NSLog(@"checkin: %@ checkout: %@", self.checkinDatePicker.date, self.checkoutDatePicker.date);
  reservationsFetch.predicate = reservationPredicate;                                      // puts together the fetch and the conditions predicate
  NSError *fetchError;                                                                     // sets up the error variable
  
  // puts the fetch request results into a results array
  NSArray *results = [[[HotelService sharedService] coreDataStack].managedObjectContext executeFetchRequest:reservationsFetch error:&fetchError];
  
  NSMutableArray *rooms = [NSMutableArray new]; // <- initializes a rooms array
  for (Reservation *reservation in results) {   // <- loops through the reservations in results array and adds them to the rooms array
    [rooms addObject:reservation.room];
    NSLog(@"rooms array: %@", rooms);
  }

// ******************* 2nd rooms fetch with Core Data  *******************
  NSFetchRequest *anotherRoomFetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Room"]; // <- initializes the fetch request
  NSPredicate *roomsPredicate = [NSPredicate predicateWithFormat:@"hotel.name MATCHES %@ AND NOT (self IN %@)", selectedHotel, rooms]; // Defines the predicate conditions
  anotherRoomFetchRequest.predicate = roomsPredicate;                                            // puts together the fetch and the conditions predicate
  NSError *finalError;                                                                           // sets up the error variable
//  NSArray *finalResults = [[[HotelService sharedService] coreDataStack].managedObjectContext executeFetchRequest:anotherFetchRequest error:&finalError];
// ******************* Gets final rooms with Core Data  *******************
    self.finalResults = [[[HotelService sharedService] coreDataStack].managedObjectContext executeFetchRequest:anotherRoomFetchRequest error:&finalError];
  if (finalError) {
    NSLog(@"%@", finalError.localizedDescription);
  }
  
  NSLog(@"results : %lu",(unsigned long)self.finalResults.count);
  NSLog(@"resultsArray : %@", self.finalResults);
  
// ******************* Gives availability in an alert  *******************
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:[NSString stringWithFormat:@"%@", selectedHotel] message:[NSString stringWithFormat:@"%lu rooms available!", (unsigned long)self.finalResults.count] delegate:self cancelButtonTitle:@"ok" otherButtonTitles:nil, nil];
  [alert show];

//    
//  }
}


// I wanted to pass over the array that had all the rooms, but I couldn't get it to work
//-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//  if ([segue.identifier isEqualToString:@"SHOW_AVAILABILITY"]) {
//    ShowAvailabilityViewController *destinationVC = segue.destinationViewController;
//    destinationVC.forSelectedDates = self.finalResults;
//  }
//}




@end
