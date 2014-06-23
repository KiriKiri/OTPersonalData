//
//  OTTelephoneModifier.m
//  OTPersonalDataControl
//
//  Created by KiriKiri on 26.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import "OTTelephoneModifier.h"

@implementation OTTelephoneModifier

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [self stringIsLatin:string];
}

#pragma mark -
#pragma mark overriden methods

- (void) initTextField:(UITextField *) textField
{
    [super initTextField:textField];
    textField.keyboardType = UIKeyboardTypeNumberPad;
}

#pragma mark -

- (BOOL) stringIsLatin: (NSString*) string;
{
    int index;
    unichar aChar;
    for (index = 0; index < [string length]; index++)
    {
        aChar = [string characterAtIndex: index];
        if (!(aChar >= (unsigned int)'0' && aChar <= (unsigned int)'9'))
            return FALSE;
    }
    return TRUE;
}

#pragma mark -

- (NSString *) modifyTextField:(UITextField *) textField
{
    [self.delegate setValue:textField.text];
    return textField.text;
}

@end
