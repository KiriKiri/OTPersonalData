//
//  OTUpperCaseModifier.h
//  OTPersonalDataControl
//
//  Created by KiriKiri on 19.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OTModifierProtocol.h"
#import "OTBaseModifier.h"

@interface OTUpperCaseModifier : OTBaseModifier <OTModifierProtocol>
@property (nonatomic) BOOL onlyLatin;
@end
