//
//  OTAPersonalDataConfigFactory.h
//  Online.Travel.iPad
//
//  Created by KiriKiri on 25.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OTPersonalDataConfig.h"

@interface OTAPersonalDataConfigFactory : NSObject

+ (OTPersonalDataConfig *)createAdultConfigWithIndex:(NSUInteger)index;
+ (OTPersonalDataConfig *) createEmailAndTelConfig;
@end
