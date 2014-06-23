//
//  OTEmailValidator.m
//  OTPersonalDataControl
//
//  Created by KiriKiri on 26.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import "OTEmailValidator.h"

@implementation OTEmailValidator 

- (BOOL) validate:(id) value
{
    if ([value isKindOfClass:[NSString class]])
    {
        if (!value || [value isEqualToString:@""]) {
            return NO;
        }
        NSUInteger location = [value rangeOfString:@"@"].location;
        return location != NSNotFound;
    } else if (!value) {
        return NO;
    }
    
    return NO;
}

@end
