//
//  OTBaseModifier.h
//  OTPersonalDataControl
//
//  Created by KiriKiri on 19.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OTModifierProtocol.h"
#import "OTFieldConfig.h"

extern NSString *const OTModifyPersonalDataTextField;

@interface OTBaseModifier : NSObject <OTModifierProtocol>
@property (nonatomic, weak) id<OTModifyConfigProtocol> delegate;
@end
