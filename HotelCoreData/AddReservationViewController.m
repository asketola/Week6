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

@interface AddReservationViewController ()
@property (weak, nonatomic) IBOutlet UIDatePicker *checkinDatePicker;
@property (weak, nonatomic) IBOutlet UIDatePicker *checkoutDatePicker;
@property (weak, nonatomic) IBOutlet UITextField *firstNameTextField;
@property (weak, nonatomic) IBOutlet UITextField *lastNameTextField;
@property (weak, nonatomic) IBOutlet UIButton *addReservationButtonLabel;


@end

@implementation AddReservationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}
- (IBAction)addReservationButtonPressed:(id)sender {
  NSLog(@"reservationButtonPressed!");
  Reservation *reservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:self.selectedRoom.managedObjectContext];
  reservation.startDate = self.checkinDatePicker.date;
  reservation.endDate = self.checkoutDatePicker.date;
  reservation.room = self.selectedRoom;
  Guest *guest = [NSEntityDescription insertNewObjectForEntityForName:@"Guest" inManagedObjectContext:self.selectedRoom.managedObjectContext];
  guest.firstName = self.firstNameTextField.text;
  guest.lastName = self.lastNameTextField.text;
  reservation.guest = guest;
  
  NSLog(@"%lu",(unsigned long)self.selectedRoom.reservations.count);
  
  NSError *saveError;
  [self.selectedRoom.managedObjectContext save:&saveError];
  
  if (saveError) {
    NSLog(@" %@", saveError.localizedDescription);
  }
  
}

@end
