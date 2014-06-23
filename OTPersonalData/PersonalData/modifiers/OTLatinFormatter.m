//
//  OTLatinFormatter.m
//  OTPersonalDataControl
//
//  Created by KiriKiri on 25.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import "OTLatinFormatter.h"

@implementation OTLatinFormatter

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    return [self stringIsLatin:string];
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
    [self.delegate setValue:textField.text];
    return textField.text;
}


@end
