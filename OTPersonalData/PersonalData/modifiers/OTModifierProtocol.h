//
//  OTModifierProtocol.h
//  OTPersonalDataControl
//
//  Created by KiriKiri on 19.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@protocol OTModifyConfigProtocol <NSObject>
@required
- (void) setValue:(id) value;
- (id) value;
- (void) setStringValue:(NSString *)stringValue;
- (NSString *) stringValue;
@end

@protocol OTModifierInputViewProtocol <NSObject>
- (void) setTextField:(UITextField *) textField;
- (UIView *) inputView;
@end

@protocol OTModifierProtocol <NSObject, UITextFieldDelegate>
@optional
- (id <OTModifierInputViewProtocol>) inputView;
@required
- (void) textFieldDidChange:(id) sender;
- (void) initTextField:(UITextField *) textField;
- (id <OTModifyConfigProtocol>) delegate;
- (void) setDelegate:(id <OTModifyConfigProtocol>) delegate;
- (NSString *) modifyTextField:(UITextField *) textField;
- (NSString *) stringFromValue:(id) value;
@end