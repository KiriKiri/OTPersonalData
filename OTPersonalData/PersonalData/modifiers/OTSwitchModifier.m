//
//  OTSwitchModifier.m
//  OTPersonalDataControl
//
//  Created by KiriKiri on 19.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import "OTSwitchModifier.h"

@interface OTSwitchModifier()
@property (nonatomic) int currentItem;
@end

@implementation OTSwitchModifier

- (void) updateTextFieldWithCurrentItem:(UITextField *)textField
{
    if (self.switchItems.count > 0) {
        textField.text = [self.switchItems objectAtIndex:self.currentItem];
        [self.delegate setValue:textField.text];
    }
}

- (NSString *) stringFromValue:(id)value
{
    self.currentItem = [self.switchItems indexOfObject:value];
    return [self.switchItems objectAtIndex:self.currentItem];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    self.currentItem = (self.currentItem + 1) % self.switchItems.count;
    [self updateTextFieldWithCurrentItem:textField];
    return NO;
}

#pragma mark -
#pragma mark overriden methods

- (void) initTextField:(UITextField *) textField
{
    [super initTextField:textField];
    [self updateTextFieldWithCurrentItem:textField];
}

- (id) initWithSwitchItems:(NSArray *)items
{
    self = [super init];
    if (self) {
        self.switchItems = items;
        self.currentItem = 0;
    }
    return self;
}

@end
