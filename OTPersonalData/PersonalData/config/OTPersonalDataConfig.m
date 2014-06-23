//
//  OTPersonaDataConfig.m
//  Online.Travel.iPad
//
//  Created by KiriKiri on 25.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import "OTPersonalDataConfig.h"

@implementation OTPersonalDataConfig

- (id) init
{
    self = [super init];
    if (self) {
        self.needToSave = YES;
    }
    return self;
}

- (OTFieldConfig *) getFieldConfigWithKey:(NSString *) key
{
    for (OTFieldConfig *config in self.fields)
    {
        if ([config.key isEqualToString:key])
        {
            return config;
        }
    }
    
    return nil;
}

@end
