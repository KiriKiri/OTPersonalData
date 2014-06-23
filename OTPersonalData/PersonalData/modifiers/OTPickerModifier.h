//
//  OTPickerModifier.h
//  OTPersonalDataControl
//
//  Created by KiriKiri on 19.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import "OTBaseModifier.h"

@interface OTPickerModifier : OTBaseModifier
- (id) initWithItems:(NSArray *) items;
@property (nonatomic, weak) NSArray *items;
@end

@interface OTModifierPickerClient : NSObject <OTModifierInputViewProtocol, UIPickerViewDataSource, UIPickerViewDelegate>
@property (nonatomic, weak) NSArray *items;
@property (nonatomic, strong) UIPickerView *picker;
@property (nonatomic, weak) id<OTModifyConfigProtocol> delegate;
@end

