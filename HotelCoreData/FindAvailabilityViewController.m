//
//  FindAvailabilityViewController.m
//  HotelCoreData
//
//  Created by Annemarie Ketola on 2/10/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

#import "FindAvailabilityViewController.h"

@interface FindAvailabilityViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *hotelsSegmentedButtonPressed;
@property (weak, nonatomic) IBOutlet UIDatePicker *checkinDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *checkoutDatePicker;

@end

@implementation FindAvailabilityViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)findAvailibilityButtonPressed:(id)sender {
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
