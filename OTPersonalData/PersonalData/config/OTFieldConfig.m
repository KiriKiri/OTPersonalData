//
//  OTFieldsConfig.m
//  OTPersonalDataControl
//
//  Created by KiriKiri on 19.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import "OTFieldConfig.h"

@implementation OTFieldConfig

- (id) initWithTitle:(NSString *)title subtitle:(NSString *)subtitle placeHolder:(NSString *)placeholder
{
    self = [super init];
    if (self)
    {
        self.title = title;
        self.subtitle = subtitle;
        self.placeholder = placeholder;
        self.isValid = YES;
    }
    
    return self;
}

- (id) initWithTitle:(NSString *)title
            subtitle:(NSString *)subtitle
         placeHolder:(NSString *)placeholder
           validator:(id<OTValidatorProtocol>)validator
            modifier:(id<OTModifierProtocol>)modifier
               value:(id)value
{
    self = [super init];
    if (self)
    {
        self.title = title;
        self.subtitle = subtitle;
        self.placeholder = placeholder;
        self.validator = validator;
        self.modifier = modifier;
        self.value = value;
        self.modifier.delegate = self;
        self.isValid = YES;
    }
    
    return self;
}

- (void) setModifier:(id<OTModifierProtocol>)modifier
{
    _modifier = modifier;
    _modifier.delegate = self;
}

#pragma mark -
#pragma mark public methids

- (BOOL) validate
{
    if (self.validator)
    {
        self.isValid = [self.validator validate:self.value];
    }
    return self.isValid;
}

#pragma mark -
#pragma mark OTModifyConfigProtocol

- (NSString *)valueString
{
    if (self.stringValue) {
        return self.stringValue;
    }
    
    return self.value;
}

#pragma mark -

@end
