//
//  RoomsViewController.m
//  HotelCoreData
//
//  Created by Annemarie Ketola on 2/9/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

#import "RoomsViewController.h"
#import "Room.h"
#import "AppDelegate.h"

@interface RoomsViewController () <UITableViewDataSource>;
@property (weak, nonatomic) IBOutlet UITableView *roomTableView;
@property (weak, nonatomic) NSArray *roomsArray;

@end

@implementation RoomsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.roomsArray = self.selectedHotel.rooms.allObjects;
  self.roomTableView.dataSource = self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (self.roomsArray) {
      return self.roomsArray.count;
    } else {
      return 0;
    }
  }

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ROOM_CELL" forIndexPath:indexPath];
  Room *room = self.roomsArray[indexPath.row];
  cell.textLabel.text = [NSString stringWithFormat:@"%@", room.number];
  return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"SHOW_RESERVATION"]) {
    
  }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
