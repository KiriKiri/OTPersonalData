//
//  OTDateModifier.m
//  OTPersonalDataControl
//
//  Created by KiriKiri on 19.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import "OTDateModifier.h"
#import "OTModifierProtocol.h"
#import "OTBaseModifier.h"

@implementation OTDateModifier

- (void) initTextField:(UITextField *) textField
{
    [super initTextField:textField];
}

- (id<OTModifierInputViewProtocol>) inputView
{
    OTDateModifierPickerClient *client = [[OTDateModifierPickerClient alloc] init];
    client.delegate = self.delegate;
    return client;
}

- (NSString *) stringFromValue:(id) value
{
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    return [formatter stringFromDate:value];
}

#pragma mark -

@end

@interface OTDateModifierPickerClient()
@property (nonatomic, weak) UITextField *textField;
@end

@implementation OTDateModifierPickerClient

// overriden methods

- (UIView *) inputView
{
    return self.datePicker;
}

- (void) setTextField:(UITextField *)textField
{
    _textField = textField;
    _textField.inputView = self.datePicker;
}

// internal methods

- (id) init
{
    self = [super init];
    if (self) {
        [self createDatePicker];
    }
    return self;
}

- (void) createDatePicker
{
    self.datePicker = [[UIDatePicker alloc]init];
    [self.datePicker setDate:[NSDate date]];
    [self.datePicker setDatePickerMode:UIDatePickerModeDate];
    [self.datePicker addTarget:self action:@selector(updateTextField:) forControlEvents:UIControlEventValueChanged];
}

-(void) updateTextField:(UIDatePicker *) datePicker
{
    [self.delegate setValue: datePicker.date];
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"MM-dd-yyyy"];
    NSString *stringFromDate = [formatter stringFromDate:datePicker.date];
    
    self.textField.text = stringFromDate;
    [self.delegate setStringValue: stringFromDate];
}

@end
