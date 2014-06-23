//
//  OTPersonalSavedDataViewController.m
//  Online.Travel.United
//
//  Created by KiriKiri on 23.06.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import "OTPersonalSavedDataViewController.h"

@interface OTPersonalSavedDataViewController ()

@end

@implementation OTPersonalSavedDataViewController

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.dataSource numberOfItemsInSection:self.section] + 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"Cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    
    if (indexPath.row == 0) {
        cell.textLabel.text = NSLocalizedString(@"Cancel", nil);
        cell.textLabel.textColor = [UIColor blueColor];
        cell.textLabel.textAlignment = NSTextAlignmentCenter;
        cell.accessoryType = UITableViewCellAccessoryNone;
    } else {
        cell.textLabel.text = [self.dataSource titleForItemWithIndex:indexPath.row-1 inSection:self.section];
        cell.textLabel.textColor = [UIColor blackColor];
        cell.textLabel.textAlignment = NSTextAlignmentLeft;
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    return cell;
}


#pragma mark -
#pragma mark UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row > 0) {
        [self.dataSource didTouchItemWithIndex:indexPath.row - 1 inSection:self.section];
    }
    
    if (self.popover) {
        [self.popover dismissPopoverAnimated:YES];
    }
    
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {

    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
