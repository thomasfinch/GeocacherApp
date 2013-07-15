//
//  GViewController.m
//  Geocacher
//
//  Created by Thomas Finch on 7/15/13.
//  Copyright (c) 2013 Thomas Finch. All rights reserved.
//

#import "GViewController.h"

double FESMinutesInDegreeConstant = 60.0;
double FESSecondsInMinuteConstant = 60.0;
double FESSecondsInDegreeConstant = 3600.0;

@interface GViewController ()

@end

@implementation GViewController

@synthesize latitudeLabel;
@synthesize longitudeLabel;
@synthesize altitudeLabel;
@synthesize compassLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    locationManager = [[CLLocationManager alloc] init];
    locationManager.delegate = self;
    locationManager.desiredAccuracy = kCLLocationAccuracyBest;
    locationManager.distanceFilter = kCLDistanceFilterNone;
    
    [locationManager startUpdatingLocation];
}

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations
{
    CLLocation *location = [locations lastObject];
    
    latitudeLabel.text = [self decimalToDegMinsSecs:[location coordinate].latitude type:true];
    longitudeLabel.text = [self decimalToDegMinsSecs:[location coordinate].longitude type:false];
    altitudeLabel.text = [NSString stringWithFormat:@"%f",[location altitude]];
    
    double heading = [[locationManager heading] trueHeading];
    NSString *direction = @"N";
    if (heading>=22.5 && heading<67.5)
        direction = @"NE";
    else if (heading>=67.5 && heading<112.5)
        direction = @"E";
    else if (heading>=112.5 && heading<157.5)
        direction = @"SE";
    else if (heading>=157.5 && heading<202.5)
        direction = @"S";
    else if (heading>=202.5 && heading<247.5)
        direction = @"SW";
    else if (heading>=247.5 && heading<292.5)
        direction = @"W";
    else if (heading>=292.5 && heading<337.5)
        direction = @"NW";
    else
        direction = @"N";
    
    compassLabel.text = [NSString stringWithFormat:@"%@ (%.f°)",direction,heading];
}

-(NSString*)decimalToDegMinsSecs:(double)location type:(bool)type
{
    int degrees, minutes;
    float seconds, temp;
    char direction;
    
    if (location < 0)
    {
        if (type)
            direction = 'S';
        else
            direction = 'W';
        location = -location;
    }
    else
    {
        if (type)
            direction = 'N';
        else
            direction = 'E';
    }
    
    
    degrees = floor(location);
    temp = location - floor(location);
    minutes = floor(temp*60);
    temp = (temp*60)-minutes;
    seconds = temp*60;
    
    return [NSString stringWithFormat:@"%i° %i' %.1f'' %c",degrees,minutes,seconds,direction];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidUnload {
    [self setLatitudeLabel:nil];
    [self setLongitudeLabel:nil];
    [self setAltitudeLabel:nil];
    [self setCompassLabel:nil];
    [super viewDidUnload];
}
@end
