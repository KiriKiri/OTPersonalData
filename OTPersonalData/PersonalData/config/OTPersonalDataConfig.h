//
//  OTPersonaDataConfig.h
//  Online.Travel.iPad
//
//  Created by KiriKiri on 25.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "OTFieldConfig.h"

@interface OTPersonalDataConfig : NSObject

- (OTFieldConfig *)getFieldConfigWithKey:(NSString *)key;

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) NSString *type;
@property (nonatomic, strong) NSArray  *fields;
@property (nonatomic, assign) BOOL needToSave;
@end
