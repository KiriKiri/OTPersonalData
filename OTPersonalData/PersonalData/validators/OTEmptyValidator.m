//
//  OTEmptyValidator.m
//  OTPersonalDataControl
//
//  Created by KiriKiri on 19.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import "OTEmptyValidator.h"

@implementation OTEmptyValidator

- (BOOL) validate:(id) value
{
    if ([value isKindOfClass:[NSString class]])
    {
        if (!value || [value isEqualToString:@""])
        {
            return NO;
        }
    } else if (!value)
    {
        return NO;
    }
    
    return YES;
}

@end
