//
//  OTCVVModifier.m
//  OTPersonalDataControl
//
//  Created by KiriKiri on 25.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import "OTCVVModifier.h"

@implementation OTCVVModifier

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [textField.text length] < 3 || [string isEqualToString:@""];
}

#pragma mark -
#pragma mark overriden methods

- (void) initTextField:(UITextField *) textField
{
    [super initTextField:textField];
    textField.secureTextEntry = YES;
    textField.keyboardType = UIKeyboardTypeNumberPad;
}

#pragma mark -

- (NSString *) modifyTextField:(UITextField *) textField
{
    [self.delegate setValue:textField.text];
    return textField.text;
}

@end
