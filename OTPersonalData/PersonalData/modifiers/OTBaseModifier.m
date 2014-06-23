//
//  OTBaseModifier.m
//  OTPersonalDataControl
//
//  Created by KiriKiri on 19.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import "OTBaseModifier.h"

NSString * const OTModifyPersonalDataTextField = @"OTModifyPersonalDataTextField";

@implementation OTBaseModifier

- (void) initTextField:(UITextField *) textField
{
    textField.inputView = nil;
    textField.keyboardType = UIKeyboardTypeDefault;
    textField.secureTextEntry = NO;
}

- (void) textFieldDidChange:(id) sender
{
    [self.delegate setValue:[self modifyTextField:sender]];
}

- (NSString *) stringFromValue:(id) value
{
    if ([value isKindOfClass:[NSString class]]) {
        return value;
    } else if ([value respondsToSelector:@selector(stringRepresentation)]) {
        return [value stringRepresentation];
    }
    
    return @"";
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return YES;
}

#pragma mark -
#pragma mark overriden methods

- (NSString *) modifyTextField:(UITextField *) textField
{
    return textField.text;
}

#pragma mark -

@end
