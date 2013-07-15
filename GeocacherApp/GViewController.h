//
//  GViewController.h
//  Geocacher
//
//  Created by Thomas Finch on 7/15/13.
//  Copyright (c) 2013 Thomas Finch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreLocation/CoreLocation.h>

@interface GViewController : UIViewController <CLLocationManagerDelegate>
{
    CLLocationManager *locationManager;
}

@property (weak, nonatomic) IBOutlet UILabel *latitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *longitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *altitudeLabel;
@property (weak, nonatomic) IBOutlet UILabel *compassLabel;

-(NSString*)decimalToDegMinsSecs:(double)location type:(bool)type;

@end
