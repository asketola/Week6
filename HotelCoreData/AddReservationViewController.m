//
//  AddReservationViewController.m
//  HotelCoreData
//
//  Created by Annemarie Ketola on 2/10/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

#import "AddReservationViewController.h"
#import "Reservation.h"
#import "Guest.h"
#import "HotelService.h"

@interface AddReservationViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *checkinDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *checkoutDatePicker;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UILabel *dateErrorLabel;
// @property (weak, nonatomic) IBOutlet UIButton *addReservationButtonLabel;


@end

@implementation AddReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

-(void)didReceiveMemoryWarning {
  [super didReceiveMemoryWarning];
}

- (IBAction)addReservationButtonPressed:(id)sender {
  
//  if (self.checkinDatePicker.date < self.checkoutDatePicker.date) {
//    if (self.checkinDatePicker.date != self.checkoutDatePicker.date) {
//    if (self.firstNameTextField.text != nil && self.lastNameTextField.text != nil)  {
  
// ******************* Makes the Guest with Core Data  *******************
  Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:[[HotelService sharedService] coreDataStack].managedObjectContext];
    guest.firstName = @"Anne:"; //self.firstNameTextField.text;                      // <- required Guest class property
    guest.lastName = @"Ketola"; //self.lastNameTextField.text;                       // <- required Guest class property
  
// ******************* Makes the reservation with Core Data  *******************
  [[HotelService sharedService] bookreservationForGuest:guest ForRoom:self.selectedRoom startDate:self.checkinDatePicker.date endDate:self.checkoutDatePicker.date];
  [self dismissViewControllerAnimated:true completion:nil];
    
//    } else {
//      self.dateErrorLabel.text = @"Please add names";
//    }} else {
//      self.dateErrorLabel.text = @"Same start & End date, please choose new dates";
//    } else {
//    self.dateErrorLabel.text = @"Check-out is before check-in, Please choose new dates";
//      [self refreshDatePicker];
//  }
  
// ******************* Old code prior to CoreDataStack file *******************
//  NSLog(@"reservationButtonPressed!");
//  Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.selectedRoom.managedObjectContext];
//  reservation.startDate = self.checkinDatePicker.date;
//  reservation.endDate = self.checkoutDatePicker.date;
//  reservation.room = self.selectedRoom;
//  Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:self.selectedRoom.managedObjectContext];
//  guest.firstName = @"Anne:"; //self.firstNameTextField.text;
//  guest.lastName = @"Ketola"; //self.lastNameTextField.text;
//  reservation.guest = guest;
//  
//  NSLog(@"%lu",(unsigned long)self.selectedRoom.reservations.count);
//  
//  NSError *saveError;
//  [self.selectedRoom.managedObjectContext save:&saveError];
//  
//  if (saveError) {
//    NSLog(@" %@", saveError.localizedDescription);
//  }
  
}

// ******************* Reset the datepickers after an error is called *******************
//-(void) refreshDatePicker {
//  [self.checkinDatePicker setDate:[NSDate date]];
//  NSDate *now = [NSDate date];
//  int daysToAdd = 1;
//  NSDate *newDate = [now dateByAddingTimeInterval:60*60*24*daysToAdd];
//  [self.checkoutDatePicker setDate:[NSDate newDate]];
//  NSLog(@"newdate: %@", newDate);
//}


@end
