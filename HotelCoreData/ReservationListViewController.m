//
//  ReservationListViewController.m
//  HotelCoreData
//
//  Created by Annemarie Ketola on 2/11/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

#import "ReservationListViewController.h"
#import "AddReservationViewController.h"
#import "HotelService.h"

@interface ReservationListViewController () <NSFetchedResultsControllerDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *reservationListTableView;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsContoller;

@end

@implementation ReservationListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  NSManagedObjectContext *context = [[HotelService sharedService] coreDataStack].managedObjectContext;  // sets up the context from Core Data
  
  NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] initWithEntityName:@"Reservation"];            // initiates the fetch request
  NSPredicate *predicate = [NSPredicate predicateWithFormat:@"room == %@", self.selectedRoom];          // cets up the predicate conditions
  NSSortDescriptor *sortDescriptor = [NSSortDescriptor sortDescriptorWithKey:@"startDate" ascending:true];
  fetchRequest.predicate = predicate;                                                        // hook up fetch and predicate conditions up together
  fetchRequest.sortDescriptors = @[sortDescriptor];
  self.fetchedResultsContoller = [[NSFetchedResultsController alloc] initWithFetchRequest:fetchRequest managedObjectContext:context sectionNameKeyPath:nil cacheName:nil];                                                   // initializes the fetch controller/manager
  self.fetchedResultsContoller.delegate = self;                                              // required for the controller delegate
  self.reservationListTableView.dataSource = self;                                           // required for the data source
  NSError *fetchError;                                                                       // Defines the fetchError
  [self.fetchedResultsContoller performFetch:&fetchError];
  if (fetchError) {
    NSLog(@" %@", fetchError);
  }
    // Do any additional setup after loading the view.
}

// ******************* Auto-update the reservations  *******************
-(void)controllerWillChangeContent:(NSFetchedResultsController *)controller {
  [self.reservationListTableView beginUpdates];
}

-(void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
  [self.reservationListTableView endUpdates];
}

-(void)controller:(NSFetchedResultsController *)controller didChangeObject:(id)anObject atIndexPath:(NSIndexPath *)indexPath forChangeType:(NSFetchedResultsChangeType)type newIndexPath:(NSIndexPath *)newIndexPath {
  
  switch (type) {
    case NSFetchedResultsChangeInsert:
      [self.reservationListTableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
      case NSFetchedResultsChangeDelete:
      [self.reservationListTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
      break;
      case NSFetchedResultsChangeUpdate:
      [self configureCell:[self.reservationListTableView cellForRowAtIndexPath:indexPath] atIndexPath:indexPath];
      break;
      case NSFetchedResultsChangeMove:
      [self.reservationListTableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
      [self.reservationListTableView insertRowsAtIndexPaths:@[newIndexPath] withRowAnimation:UITableViewRowAnimationFade];
      default:
      break;
  }
}

// ******************* How to draw the cells *******************
-(void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath*)indexPath {
  Reservation *reservation = [self.fetchedResultsContoller objectAtIndexPath:indexPath];
  cell.textLabel.text = [NSString stringWithFormat:@" room: %@", reservation.room.number];
}

// ******************* How many sections to draw *******************
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
  return [[self.fetchedResultsContoller sections] count];
}

// ******************* How many cells to draw *******************
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
  NSArray *sections = [self.fetchedResultsContoller sections];
  id<NSFetchedResultsSectionInfo> sectionInfo = [sections objectAtIndex:section];
  return [sectionInfo numberOfObjects];
}

// ******************* How to draw the cells *******************
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
  UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RESERVATIONS_CELL" forIndexPath:indexPath];
  [self configureCell:cell atIndexPath:indexPath];
  return cell;
}

// ******************* Go to the correct View Controller *******************
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
  if ([segue.identifier isEqualToString:@"ADD_RESERVATION"]) {
    AddReservationViewController *destinationVC = segue.destinationViewController;
    destinationVC.selectedRoom = self.selectedRoom;
  }
}


@end
