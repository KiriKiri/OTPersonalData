//
//  OTFieldsConfig.h
//  OTPersonalDataControl
//
//  Created by KiriKiri on 19.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OTValidatorProtocol.h"
#import "OTModifierProtocol.h"

@interface OTFieldConfig : NSObject <OTModifyConfigProtocol>

- (id) initWithTitle:(NSString *)title subtitle:(NSString *)subtitle placeHolder:(NSString *)placeholder;
- (id) initWithTitle:(NSString *)title
            subtitle:(NSString *)subtitle
         placeHolder:(NSString *)placeholder
           validator:(id<OTValidatorProtocol>)validator
            modifier:(id<OTModifierProtocol>)modifier
               value:(id)value;

@property (nonatomic, strong) NSString *key;
@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *subtitle;
@property (nonatomic, strong) NSString *placeholder;
@property (nonatomic) BOOL isValid;
@property (nonatomic, strong) id <OTValidatorProtocol> validator;
@property (nonatomic, strong) id <OTModifierProtocol> modifier;
@property (nonatomic, strong) id value;
@property (nonatomic, strong) NSString *stringValue;

- (BOOL)validate;
- (NSString *)valueString;

@end