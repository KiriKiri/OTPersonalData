//
//  OTAPersonalDataConfigFactory.m
//  Online.Travel.iPad
//
//  Created by KiriKiri on 25.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import "OTAPersonalDataConfigFactory.h"
#import "OTFieldConfig.h"
#import "OTUpperCaseModifier.h"
#import "OTDateModifier.h"
#import "OTSwitchModifier.h"
#import "OTEmptyValidator.h"
#import "OTPickerModifier.h"
#import "OTAdultDateValidator.h"
#import "OTEmailValidator.h"
#import "OTEmailModifier.h"
#import "OTTelephoneModifier.h"

@implementation OTAPersonalDataConfigFactory

+ (NSString *) convertGender:(NSString *) gender
{
    if ([gender isEqualToString:@"Male"]) {
        return @"M";
    }
    return @"F";
}

+ (NSString *) convertDate:(NSDate *) date
{
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    [df setDateFormat:@"yyyyMMdd"];
    return [df stringFromDate:date];
}

+ (OTPersonalDataConfig *)createAdultConfigWithIndex:(NSUInteger)index
{
    // Name
    OTFieldConfig *nameConfig = [[OTFieldConfig alloc] initWithTitle:NSLocalizedString(@"First Name", nil) subtitle:NSLocalizedString(@"Only latin characters", nil) placeHolder:@"Ivan"];
    OTUpperCaseModifier *nameModifier = [[OTUpperCaseModifier alloc] init];
    nameConfig.key = @"firstName";
    nameConfig.modifier = nameModifier;
    nameConfig.validator = [[OTEmptyValidator alloc] init];
    
    // Surname
    OTFieldConfig *surnameConfig = [[OTFieldConfig alloc] initWithTitle:NSLocalizedString(@"Last Name", nil) subtitle:NSLocalizedString(@"Only latin characters", nil) placeHolder:@"Ivanov"];
    OTUpperCaseModifier *surnameModifier = [[OTUpperCaseModifier alloc] init];
    surnameConfig.key = @"lastName";
    surnameConfig.modifier = surnameModifier;
    surnameConfig.validator = [[OTEmptyValidator alloc] init];
    
    // Birth Date
    OTFieldConfig *dateConfig = [[OTFieldConfig alloc] initWithTitle:NSLocalizedString(@"Date of Birth", nil) subtitle:@"12+" placeHolder:@"08-07-1990"];
    OTDateModifier *dateModifier = [[OTDateModifier alloc] init];
    dateConfig.key = @"birthDate";
    dateConfig.modifier = dateModifier;
    dateConfig.validator = [[OTAdultDateValidator alloc] init];
    
    // Sex
    OTFieldConfig *sexConfig = [[OTFieldConfig alloc] initWithTitle:NSLocalizedString(@"Sex", nil) subtitle:@"" placeHolder:@"Male/Female"];
    OTSwitchModifier *sexModifier = [[OTSwitchModifier alloc] initWithSwitchItems:@[@"Male", @"Female"]];
    sexConfig.key = @"gender";
    sexConfig.modifier = sexModifier;
    sexConfig.validator = [[OTEmptyValidator alloc] init];
    
    // Document
    OTFieldConfig *documentConfig = [[OTFieldConfig alloc] initWithTitle:NSLocalizedString(@"Document Number", nil) subtitle:NSLocalizedString(@"Your document number", nil) placeHolder:@"EN536441"];
    OTUpperCaseModifier *documentModifier = [[OTUpperCaseModifier alloc] init];
    documentModifier.onlyLatin = NO;
    documentConfig.key = @"passNumber";
    documentConfig.modifier = documentModifier;
    documentConfig.validator = [[OTEmptyValidator alloc] init];
    
    OTPersonalDataConfig *personalDataConfig = [[OTPersonalDataConfig alloc] init];
    personalDataConfig.fields = @[nameConfig,
                                 surnameConfig,
                                 sexConfig,
                                 dateConfig,
                                 documentConfig];

    personalDataConfig.type = @"ADT";
    personalDataConfig.title = NSLocalizedString(@"Passenger", nil);
    
    return personalDataConfig;
}

+ (OTPersonalDataConfig *) createEmailAndTelConfig
{
    // Tel and email data
    OTPersonalDataConfig *contactsDataConfig = [[OTPersonalDataConfig alloc] init];
    contactsDataConfig.type = @"contacts";
    contactsDataConfig.title = NSLocalizedString(@"Customer Info", nil);
    
    // Email
    OTFieldConfig *emailConfig = [[OTFieldConfig alloc] initWithTitle:NSLocalizedString(@"Email", nil) subtitle:@"" placeHolder:@"your@mail.com"];
    OTEmailModifier *emailModifier = [[OTEmailModifier alloc] init];
    OTEmailValidator *emailValidator = [[OTEmailValidator alloc] init];
    emailConfig.key = @"email";
    emailConfig.modifier = emailModifier;
    emailConfig.validator = emailValidator;
    
    // Phone
    OTFieldConfig *phoneConfig = [[OTFieldConfig alloc] initWithTitle:NSLocalizedString(@"Phone", nil) subtitle:NSLocalizedString(@"Phone number", nil) placeHolder:@"380501234567"];
    OTTelephoneModifier *phoneModifier = [[OTTelephoneModifier alloc] init];
    OTEmptyValidator *phoneValidator = [[OTEmptyValidator alloc] init];
    phoneConfig.key = @"telephone";
    phoneConfig.modifier = phoneModifier;
    phoneConfig.validator = phoneValidator;
    
    contactsDataConfig.fields = @[emailConfig, phoneConfig];
    return contactsDataConfig;
}

@end
