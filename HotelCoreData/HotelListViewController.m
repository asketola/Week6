//
//  HotelListViewController.m
//  HotelCoreData
//
//  Created by Annemarie Ketola on 2/9/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

#import "HotelListViewController.h"
#import "AppDelegate.h"
#import "Hotel.h"
#import "RoomsViewController.h"
#import "HotelService.h"

@interface HotelListViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *hotelTableView;
@property (strong, nonatomic) NSArray *hotelsArray;

@end

@implementation HotelListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.hotelTableView.dataSource = self;                                   // <- for the tableViewDataSource requirements
// Delegate code prior to CoreDataStack input
//  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
//  NSManagedObjectContext *context = appDelegate.managedObjectContext;
//  NSFetchRequest *fetchRequest = [MOM fetchRequestTemplateForName:@"HotelFetch"];
  
  
// ******************* Find Hotels *******************
  NSFetchRequest *fetchHotelRequest = [[NSFetchRequest alloc] initWithEntityName:@"Hotel"];  // initialize the fetch
  NSError *fetchHotelError;
//  NSArray *hotelResults = [context executeFetchRequest:fetchHotelRequest error:&fetchHotelError];
  NSArray *hotelResults = [[[HotelService sharedService] coreDataStack].managedObjectContext executeFetchRequest:fetchHotelRequest error:&fetchHotelError];                                                      // makes an array to store the results from the HotelService singleton
  if (!fetchHotelError) {                                                  // <- if there is no error
    self.hotelsArray = hotelResults;                                       // <- store the results in the global variables hotelsArray
    [self.hotelTableView reloadData];                                      // <- display on the tableView
    NSLog(@"hotelsArray: %@", self.hotelsArray);
  }
} // <- close ViewDidLoad


// ******************* How many cells to draw *******************
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (self.hotelsArray) {                                                  // <- check to make sure a hotelsArray was created
    return self.hotelsArray.count;                                         // <- if so, find its count
  } else {
    return 0;                                                              // <- otherwise return zero
  }
}

// ******************* What to draw in the cells *******************
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HOTEL_CELL" forIndexPath:indexPath];
  Hotel *hotel = self.hotelsArray[indexPath.row];
  cell.textLabel.text = hotel.name;
  return cell;
}

// ******************* What to send to the next screen *******************
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"SHOW_ROOMS"]) {                  // <- make sure its the correct segue
    RoomsViewController *destinationVC = segue.destinationViewController;  // <- define the next view controller
    NSIndexPath *indexPath = self.hotelTableView.indexPathForSelectedRow;  // <- define which hotel was tapped
    Hotel *hotel = self.hotelsArray[indexPath.row];
    destinationVC.selectedHotel = hotel;                                   // <- send selectedHotel variable over to the next viewController
    NSLog(@"selectedHotel: %@", hotel);
  }
}


@end
