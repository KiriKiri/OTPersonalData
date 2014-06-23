//
//  OTPersonalSavedDataViewController.h
//  Online.Travel.United
//
//  Created by KiriKiri on 23.06.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTPersonalSavedDataView.h"

@interface OTPersonalSavedDataViewController : UIViewController
@property (nonatomic, assign) NSUInteger section;
@property (nonatomic, weak) id<OTPersonalSavedDataSource> dataSource;
@property (nonatomic, weak) UIPopoverController *popover;
@end
