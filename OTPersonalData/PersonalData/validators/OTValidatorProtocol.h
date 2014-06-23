//
//  OTValidatorProtocol.h
//  OTPersonalDataControl
//
//  Created by KiriKiri on 19.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import <Foundation/Foundation.h>

@protocol OTValidatorProtocol <NSObject>
@required
- (BOOL) validate:(id) value;
@end
