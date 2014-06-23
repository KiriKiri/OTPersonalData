//
//  OTDateModifier.h
//  OTPersonalDataControl
//
//  Created by KiriKiri on 19.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OTBaseModifier.h"
#import "OTModifierProtocol.h"

@interface OTDateModifier : OTBaseModifier <OTModifierProtocol>
@end

@interface OTDateModifierPickerClient : NSObject <OTModifierInputViewProtocol>
@property (nonatomic, strong) UIDatePicker *datePicker;
@property (nonatomic, weak) id<OTModifyConfigProtocol> delegate;
-(void) updateTextField:(UIDatePicker *) datePicker;
@end
