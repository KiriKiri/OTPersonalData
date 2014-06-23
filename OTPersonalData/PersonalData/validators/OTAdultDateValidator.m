//
//  OTAdultDateValidator.m
//  Online.Travel.iPad
//
//  Created by KiriKiri on 26.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import "OTAdultDateValidator.h"
#import "NSDate+convenience.h"

@implementation OTAdultDateValidator

- (BOOL) validate:(id) value
{
    if ([value isKindOfClass:[NSDate class]])
    {
        NSDate *date = (NSDate *) value;
        NSDate *today = [NSDate new];
        NSTimeInterval delta = [today timeIntervalSinceDate:date];
        NSInteger years = delta / 60 / 60 / 24 / 364;
        return years >= 12;
    }
    return NO;
}

@end
