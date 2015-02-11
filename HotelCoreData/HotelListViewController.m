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

@interface HotelListViewController () <UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *hotelTableView;
@property (strong, nonatomic) NSArray *hotelsArray;

@end

@implementation HotelListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  self.hotelTableView.dataSource = self;
  AppDelegate *appDelegate = [UIApplication sharedApplication].delegate;
  NSManagedObjectContext *context = appDelegate.managedObjectContext;
  
  NSFetchRequest *fetchHotelRequest = [[NSFetchRequest alloc] initWithEntityName:@"Hotel"];
  
  NSError *fetchHotelError;
  
  NSArray *hotelResults = [context executeFetchRequest:fetchHotelRequest error:&fetchHotelError];
  if (!fetchHotelError) {
    self.hotelsArray = hotelResults;
    [self.hotelTableView reloadData];
  }
    // Do any additional setup after loading the view.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  if (self.hotelsArray) {
    return self.hotelsArray.count;
  } else {
    return 0;
  }
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"HOTEL_CELL" forIndexPath:indexPath];
  Hotel *hotel = self.hotelsArray[indexPath.row];
  cell.textLabel.text = hotel.name;
  return cell;
}

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"SHOW_ROOMS"]) {
    RoomsViewController *destinationVC = segue.destinationViewController;
    NSIndexPath *indexPath = self.hotelTableView.indexPathForSelectedRow;
    Hotel *hotel = self.hotelsArray[indexPath.row];
    destinationVC.selectedHotel = hotel;
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
