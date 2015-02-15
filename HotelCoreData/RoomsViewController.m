//
//  RoomsViewController.m
//  HotelCoreData
//
//  Created by Annemarie Ketola on 2/9/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

#import "RoomsViewController.h"
#import "Room.h"
#import "AddReservationViewController.h"
#import "ReservationListViewController.h"


@interface RoomsViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *roomTableView;
@property (strong, nonatomic) NSArray *roomsArray;

@end

@implementation RoomsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.roomsArray = self.selectedHotel.rooms.allObjects;            // <- put all the objects from inside the selectedHotel variable into an array
  self.roomTableView.dataSource = self;                                            // <- for the UITableViewDataSource requirements
}

// ******************* How many cells to draw *******************
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.roomsArray.count;
//    if (self.roomsArray) {
//      return self.roomsArray.count;
//    } else {
//      return 0;
//    }
  }

// ******************* What to draw in the cells *******************
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ROOM_CELL" forIndexPath:indexPath];
  Room *room = self.roomsArray[indexPath.row];                                       // <- use the Room class
  cell.textLabel.text = [NSString stringWithFormat:@"Room# %@", room.number];        // <- set the text for the room
  return cell;
}

// ******************* What to send to the next screen *******************
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"SHOW_RESERVATION_LIST"]) {                  // <- make sure its the correct segue
    AddReservationViewController *destinationVC = segue.destinationViewController;    // <- give it a destination View Controller
    NSIndexPath *indexPath = self.roomTableView.indexPathForSelectedRow;              // <- define which room was tapped
    Room *room = self.roomsArray[indexPath.row];
    destinationVC.selectedRoom = room;                                                // <- variable we are passing over to the next screen
    NSLog(@"roomsArray: %@", self.roomsArray);
    NSLog(@"selectedRoom: %@", room);
    
  }
}

@end
