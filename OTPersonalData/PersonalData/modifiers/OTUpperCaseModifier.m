//
//  OTUpperCaseModifier.m
//  OTPersonalDataControl
//
//  Created by KiriKiri on 19.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import "OTUpperCaseModifier.h"

@implementation OTUpperCaseModifier

- (id) init
{
    self = [super init];
    if (self) {
        self.onlyLatin = YES;
    }
    return self;
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.onlyLatin) {
        return [self stringIsLatin:string];
    }
    return YES;
}

#pragma mark -

- (BOOL) stringIsLatin: (NSString*) string;
{
    int index;
    unichar aChar;
    for (index = 0; index < [string length]; index++)
    {
        aChar = [string characterAtIndex: index];
        if (!(aChar >= (unsigned int)'a' && aChar <= (unsigned int)'z') &&
            !(aChar >= (unsigned int)'A' && aChar <= (unsigned int)'Z') )
            return FALSE;
    }
    return TRUE;
}

#pragma mark -

- (NSString *) modifyTextField:(UITextField *) textField
{
    textField.text = [textField.text uppercaseString];
    [self.delegate setValue:textField.text];
    return [textField.text uppercaseString];
}

@end
