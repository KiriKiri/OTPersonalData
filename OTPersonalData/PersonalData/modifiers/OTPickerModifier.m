//
//  OTPickerModifier.m
//  OTPersonalDataControl
//
//  Created by KiriKiri on 19.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import "OTPickerModifier.h"

@implementation OTPickerModifier

- (id) initWithItems:(NSArray *) items
{
    self = [super init];
    if (self) {
        self.items = items;
    }
    return self;
}

- (void) initTextField:(UITextField *) textField
{
    [super initTextField:textField];
}

- (id <OTModifierInputViewProtocol>) inputView
{
    OTModifierPickerClient *client = [[OTModifierPickerClient alloc] init];
    client.items = self.items;
    client.delegate = self.delegate;
    return client;
}

@end

@interface OTModifierPickerClient()
@property (nonatomic, weak) UITextField *textField;
@end

@implementation OTModifierPickerClient

- (void) setTextField:(UITextField *)textField
{
    _textField = textField;
    _textField.inputView = self.picker;
}

- (UIView *) inputView
{
    return self.picker;
}

- (id) init
{
    self = [super init];
    if (self) {
        [self createPicker];
    }
    return self;
}

- (void) createPicker
{
    self.picker = [[UIPickerView alloc] init];
    self.picker.delegate = self;
    self.picker.dataSource = self;
}

#pragma mark -
#pragma mark UIPickerViewDataSource

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return self.items.count;
}

#pragma mark -
#pragma mark UIPickerViewDelegate

- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [self.items objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSString *string = [self.items objectAtIndex:row];
    [self.delegate setValue: string];
    self.textField.text = string;
}

@end
