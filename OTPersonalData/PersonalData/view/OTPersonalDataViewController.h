//
//  OTPersonalDataViewController.h
//  OTPersonalDataControl
//
//  Created by KiriKiri on 19.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol OTPersonalDataViewControllerDelegate <NSObject>

@optional
- (void)performSuccessActionWithConfig:(NSArray *)config;

@end

@interface OTPersonalDataViewController : UIViewController <UITableViewDataSource, UITableViewDelegate,
                                                            UITextFieldDelegate, UIScrollViewDelegate>
- (CGSize)fullSizeOfTableView;
- (BOOL)handleSendButtonTouch;

@property (weak,   nonatomic) id delegate;
@property (weak,   nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) NSArray *config;
@end
