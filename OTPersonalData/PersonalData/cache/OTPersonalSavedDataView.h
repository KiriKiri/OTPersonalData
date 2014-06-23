//
//  OTPersonalSavedDataView.h
//  Online.Travel.United
//
//  Created by KiriKiri on 20.06.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OTPersonalSavedDataSource <NSObject>
@required
- (int) numberOfItemsInSection:(NSUInteger)section;
- (NSString *) titleForItemWithIndex:(NSUInteger)index inSection:(NSUInteger)section;
@optional
- (void) didTouchItemWithIndex:(NSUInteger)index inSection:(NSUInteger)section;
@end

@interface OTPersonalSavedDataView : UIView
@property (nonatomic, assign) int section;
@property (nonatomic, weak) id<OTPersonalSavedDataSource> dataSource;
@property (nonatomic, weak) UIViewController *targetViewController;
@end
