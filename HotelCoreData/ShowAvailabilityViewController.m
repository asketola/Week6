//
//  ShowAvailabilityViewController.m
//  HotelCoreData
//
//  Created by Annemarie Ketola on 2/14/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

#import "ShowAvailabilityViewController.h"
#import "Room.h"
#import "Hotel.h"


@interface ShowAvailabilityViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *showRoomsAvailTableView;
@property (strong, nonatomic) NSArray *showRoomsAvailArray;

@end

@implementation ShowAvailabilityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.showRoomsAvailArray = self.forSelectedDates.rooms.allObjects;
  self.showRoomsAvailTableView.dataSource = self;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  return self.showRoomsAvailArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SHOW_AVAIL_RM_CELL" forIndexPath:indexPath];
 // Room *room = self.showRoomsAvailTableView[indexPath.row];
//  cell.textLabel.text = [NSString stringWithFormat:@"Room# %@", room.number];
  return cell;
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
