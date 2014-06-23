//
//  OTEmailModifier.m
//  OTPersonalDataControl
//
//  Created by KiriKiri on 26.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import "OTEmailModifier.h"

@implementation OTEmailModifier

#pragma mark -
#pragma mark overriden methods

- (void) initTextField:(UITextField *) textField
{
    [super initTextField:textField];
    textField.keyboardType = UIKeyboardTypeEmailAddress;
}

#pragma mark -

- (NSString *) modifyTextField:(UITextField *) textField
{
    [self.delegate setValue:textField.text];
    return textField.text;
}

@end
