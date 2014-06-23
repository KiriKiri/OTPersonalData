//
//  OTPersonalSavedDataView.m
//  Online.Travel.United
//
//  Created by KiriKiri on 20.06.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import "OTPersonalSavedDataView.h"
#import "OTPersonalSavedDataViewController.h"

@interface OTPersonalSavedDataView ()
@property (nonatomic, strong) NSMutableArray *buttons;
@property (nonatomic, strong) UIPopoverController* popover;
@end

@implementation OTPersonalSavedDataView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self updateView];
    }
    return self;
}

- (void) setDataSource:(id<OTPersonalSavedDataSource>)dataSource
{
    _dataSource = dataSource;
    [self updateView];
}

- (void) updateView
{
    
    if(!self.dataSource) {
        return;
    }
    
    self.buttons = [[NSMutableArray alloc] init];
    
    NSInteger maxItems = self.frame.size.width / 120;
    NSUInteger count = MIN(maxItems, [self.dataSource numberOfItemsInSection:self.section]);

    for (int i=0; i < count; i++) {
        UIButton *dataButton = [self createDataButtonWithIndex:i];
        [dataButton setTitle:[self.dataSource titleForItemWithIndex:i inSection:self.section] forState:UIControlStateNormal];
        [self addSubview:dataButton];
        
        [self.buttons addObject:dataButton];
        [dataButton addTarget:self action:@selector(didTouchDataButton:) forControlEvents:UIControlEventTouchUpInside];
    }
    
    if (maxItems < [self.dataSource numberOfItemsInSection:self.section]) {
        UIButton *moreButton = [self createDataButtonWithIndex:count];
        moreButton.frame = CGRectMake(moreButton.frame.origin.x, moreButton.frame.origin.y, 80, moreButton.frame.size.height);
        [moreButton setTitle:@"..." forState:UIControlStateNormal];
        [self addSubview:moreButton];
        
        [moreButton addTarget:self action:@selector(didTouchMoreButton:) forControlEvents:UIControlEventTouchUpInside];
    }
}

- (UIButton *) createDataButtonWithIndex:(int)index
{
    UIButton *dataButton = [[UIButton alloc] initWithFrame:CGRectMake(index * 110 + 10, 10, 100, 20)];
    [dataButton setBackgroundColor:[UIColor darkGrayColor]];
    [dataButton setTintColor:[UIColor blackColor]];
    [dataButton.titleLabel setFont:[UIFont systemFontOfSize:14.0]];
    [dataButton.titleLabel setTextColor:[UIColor whiteColor]];
    return dataButton;
}

- (void) didTouchMoreButton:(UIButton *) sender
{
    OTPersonalSavedDataViewController *contentPopover = [[OTPersonalSavedDataViewController alloc] initWithNibName:@"OTPersonalSavedDataViewController" bundle:[NSBundle mainBundle]];
    contentPopover.section = self.section;
    contentPopover.dataSource = self.dataSource;
    
    if ([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPhone) {
        [self.targetViewController presentViewController:contentPopover animated:YES completion:nil];
    } else {
        self.popover = [[UIPopoverController alloc] initWithContentViewController:contentPopover];
        [self.popover presentPopoverFromRect:sender.frame inView:self permittedArrowDirections:UIPopoverArrowDirectionDown animated:YES];
        contentPopover.popover = self.popover;
    }
}

- (void) didTouchDataButton:(id) sender
{
    NSUInteger index = [self.buttons indexOfObject:sender];
    
    if ([self.dataSource respondsToSelector:@selector(didTouchItemWithIndex:inSection:)]) {
        [self.dataSource didTouchItemWithIndex:index inSection:self.section];
    }
}

@end
