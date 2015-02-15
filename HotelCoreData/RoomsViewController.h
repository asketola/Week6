//
//  RoomsViewController.h
//  HotelCoreData
//
//  Created by Annemarie Ketola on 2/9/15.
//  Copyright (c) 2015 Up Early, LLC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Hotel.h"

@interface RoomsViewController : UIViewController
@property (strong, nonatomic) Hotel *selectedHotel;                            // <- variable that was passed from the HotelListViewController

@end
