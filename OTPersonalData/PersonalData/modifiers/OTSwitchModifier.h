//
//  OTSwitchModifier.h
//  OTPersonalDataControl
//
//  Created by KiriKiri on 19.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import "OTBaseModifier.h"

@interface OTSwitchModifier : OTBaseModifier
@property (nonatomic, strong) NSArray *switchItems;
- (id) initWithSwitchItems:(NSArray *)items;
@end
