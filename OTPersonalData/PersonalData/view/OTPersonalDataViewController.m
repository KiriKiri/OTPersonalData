//
//  OTPersonalDataViewController.m
//  OTPersonalDataControl
//
//  Created by KiriKiri on 19.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import "OTPersonalDataViewController.h"
#import "OTPersonalDataTableViewCell.h"
#import "OTEmptyValidator.h"
#import "OTUpperCaseModifier.h"
#import "OTFieldConfig.h"
#import "OTUpperCaseModifier.h"
#import "OTEmptyValidator.h"
#import "OTDateModifier.h"
#import "OTSwitchModifier.h"
#import "OTPickerModifier.h"
#import "OTPersonalDataTableFinalFooterView.h"
#import "OTPersonalDataConfig.h"
#import "OTPersonalSavedDataView.h"

@interface OTPersonalDataViewController ()

@property (nonatomic) NSUInteger places;

@end

@implementation OTPersonalDataViewController
@synthesize config = _config;

- (CGSize)fullSizeOfTableView
{
    [self.tableView layoutIfNeeded];
    return self.tableView.contentSize;
}

#pragma mark -
#pragma mark getters/settrs

- (void)setConfig:(NSArray *)config
{
    _config = config;
    [self.tableView reloadData];
}

#pragma mark -
#pragma mark UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    OTPersonalDataConfig *personalDataConfig = [self.config objectAtIndex:section];
    return [personalDataConfig.fields count];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return self.config.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    static NSString *identifier = @"PersonalDataCell";
    OTPersonalDataTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    
    if (cell == nil) {
        [tableView registerNib:[UINib nibWithNibName:@"OTPersonalDataTableViewCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:identifier];
        cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    }
    

    OTPersonalDataConfig *personalDataConfig = [self.config objectAtIndex:indexPath.section];
    OTFieldConfig *field = [personalDataConfig.fields objectAtIndex:indexPath.row];
    
    cell.isValid = field.isValid;
    cell.titleLabel.text = field.title;
    cell.descriptionLabel.text = field.subtitle;
    cell.valueTextField.placeholder = field.placeholder;
    cell.valueTextField.text = [field valueString];
    cell.modifierDelegate = field.modifier;
    
    [cell.valueTextField addTarget:self action:@selector(handleTextFieldEditingDidBegin:) forControlEvents:UIControlEventEditingDidBegin];

    if ([field.subtitle isEqualToString:@""]) {
        cell.descriptionHidden = YES;
    }
    
    return cell;
}

#pragma mark -
#pragma mark UITableViewDelegate

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    if (section == self.config.count - 1)
    {
        return 40.0;
    }
    return 0.0;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    if (section == self.config.count - 1)
    {
        OTPersonalSavedDataView *footer = [[OTPersonalSavedDataView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
        footer.section = section;
        footer.dataSource = self;
        footer.targetViewController = self;
        return footer;
    }
    return nil;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    NSString *title = ((OTPersonalDataConfig *)[self.config objectAtIndex:section]).title;
    if (title && ![title isEqualToString:@""])
    {
        UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 45)];
        UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 10, 300, 30)];
        titleLabel.backgroundColor = [UIColor clearColor];
        titleLabel.text = title;
        titleLabel.font = [UIFont systemFontOfSize:15];
        titleLabel.textColor = [UIColor blackColor];
        [headerView addSubview:titleLabel];
        
        return headerView;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    NSString *title = ((OTPersonalDataConfig *)[self.config objectAtIndex:section]).title;
    if (title && ![title isEqualToString:@""])
    {
        return 45.0;
    }
    
    return 0.0;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath
{
    return NO;
}

- (void) handleTextFieldEditingDidBegin:(UITextField*) sender
{
    
}

#pragma mark -

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _config = @[];
    }
    return self;
}

- (BOOL)handleSendButtonTouch
{
    [[[UIApplication sharedApplication] keyWindow] endEditing:YES];
    
    NSMutableArray *cellsToReload = [NSMutableArray array];
    int index = 0;
    int section = 0;
    BOOL success = YES;
    for (OTPersonalDataConfig *sectionConfig in self.config)
    {
        for (OTFieldConfig* fieldConfig in sectionConfig.fields)
        {
            BOOL isValid = [fieldConfig isValid];
            if (isValid != [fieldConfig validate])
            {
                NSIndexPath *path = [NSIndexPath indexPathForItem:index inSection:section];
                [cellsToReload addObject:path];
            }
            if (![fieldConfig isValid])
            {
                success = NO;
            }
            index ++;
        }
        index = 0;
        section ++;
    }
    
    [self.tableView reloadRowsAtIndexPaths:cellsToReload withRowAnimation:UITableViewRowAnimationAutomatic];
    [self saveDataToDefaults];
    
    if (success && self.delegate && [self.delegate respondsToSelector:@selector(performSuccessActionWithConfig:)])
    {
        [self.delegate performSuccessActionWithConfig:self.config];
    }
    
    return success;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view sizeToFit];
    
    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.topItem.title = @"";
    
    if([UIDevice currentDevice].userInterfaceIdiom == UIUserInterfaceIdiomPad) {
        self.view.backgroundColor = [UIColor groupTableViewBackgroundColor];
        self.tableView.backgroundView = nil;
    }
    
    NSArray* nib = [[NSBundle mainBundle] loadNibNamed:@"OTPersonalDataTableFinalFooterView" owner:self options:nil];
    OTPersonalDataTableFinalFooterView *footer = (OTPersonalDataTableFinalFooterView *) [nib objectAtIndex:0];
    [footer.sendButton addTarget:self action:@selector(handleSendButtonTouch) forControlEvents:UIControlEventTouchUpInside];
    footer.frame = CGRectMake(0, 0, 320, 150);
    self.tableView.tableFooterView = footer;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

#pragma mark -
#pragma mark defaults

-(void)saveDataToDefaults
{
    for (OTPersonalDataConfig *sectionConfig in self.config)
    {
        if (!sectionConfig.needToSave) {
            continue;
        }
        
        NSMutableArray *savedData = [NSMutableArray arrayWithArray:[[NSUserDefaults standardUserDefaults] objectForKey:sectionConfig.type]];
        NSMutableDictionary *dataToSave = [[NSMutableDictionary alloc] init];
        
        for (OTFieldConfig* fieldConfig in sectionConfig.fields)
        {
            [dataToSave setObject:fieldConfig.value forKey:fieldConfig.key];
        }
        
        BOOL found = NO;
        for (NSDictionary *persistentData in savedData) {
            if ([[persistentData description] isEqualToString:[dataToSave description]]) {
                found = YES;
                break;
            }
        }
        
        if (!found) {
            [savedData addObject:dataToSave];
            [[NSUserDefaults standardUserDefaults] setObject:savedData forKey:sectionConfig.type];
            [[NSUserDefaults standardUserDefaults] synchronize];
        }
    }
}

#pragma mark -
#pragma mark OTPersonalSavedDataSource

- (int) numberOfItemsInSection:(NSUInteger)section
{
    if (section == 1)
    {
        OTPersonalDataConfig *sectionConfig = [self.config objectAtIndex:section];
        NSArray *savedData = [[NSUserDefaults standardUserDefaults] objectForKey:sectionConfig.type];
        return [savedData count];
    }
    
    return 0;
}

- (NSString *) titleForItemWithIndex:(NSUInteger)index inSection:(NSUInteger)section
{
    OTPersonalDataConfig *sectionConfig = [self.config objectAtIndex:section];
    NSArray *savedData = [[NSUserDefaults standardUserDefaults] objectForKey:sectionConfig.type];
    NSDictionary *data = [savedData objectAtIndex:index];
    
    return [[NSString stringWithFormat:@"%@ %@", [[data objectForKey:@"firstName"] lowercaseString], [[data objectForKey:@"lastName"] lowercaseString]] capitalizedString];
}

- (void) didTouchItemWithIndex:(NSUInteger)index inSection:(NSUInteger)section
{
    OTPersonalDataConfig *sectionConfig = [self.config objectAtIndex:section];
    NSArray *savedData = [[NSUserDefaults standardUserDefaults] objectForKey:sectionConfig.type];
    NSDictionary *data = [savedData objectAtIndex:index];
    
    for (OTFieldConfig* field in sectionConfig.fields) {
        field.value = [data objectForKey:field.key];
        field.stringValue = [field.modifier stringFromValue:field.value];
    }
    
    [self.tableView reloadSections:[NSIndexSet indexSetWithIndex:section] withRowAnimation:UITableViewRowAnimationAutomatic];
}

#pragma mark -
@end
