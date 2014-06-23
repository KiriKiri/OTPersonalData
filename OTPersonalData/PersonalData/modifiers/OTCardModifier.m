//
//  OTCardModifier.m
//  OTPersonalDataControl
//
//  Created by KiriKiri on 25.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import "OTCardModifier.h"

@interface OTCardModifier()
@property (nonatomic) NSString *previousTextFieldContent;
@property (nonatomic) UITextRange *previousSelection;
@end

@implementation OTCardModifier

#pragma mark -
#pragma mark UITextFieldDelegate

// Version 1.1
// Source and explanation: http://stackoverflow.com/a/19161529/1709587
-(void)reformatAsCardNumber:(UITextField *)textField
{
    // In order to make the cursor end up positioned correctly, we need to
    // explicitly reposition it after we inject spaces into the text.
    // targetCursorPosition keeps track of where the cursor needs to end up as
    // we modify the string, and at the end we set the cursor position to it.
    NSUInteger targetCursorPosition =
    [textField offsetFromPosition:textField.beginningOfDocument
                       toPosition:textField.selectedTextRange.start];
    
    NSString *cardNumberWithoutSpaces =
    [self removeNonDigits:textField.text
andPreserveCursorPosition:&targetCursorPosition];
    
    if ([cardNumberWithoutSpaces length] > 16) {
        // If the user is trying to enter more than 16 digits, we prevent
        // their change, leaving the text field in its previous state
        [textField setText:self.previousTextFieldContent];
        textField.selectedTextRange = self.previousSelection;
        return;
    }
    
    NSString *cardNumberWithSpaces =
    [self insertSpacesEveryFourDigitsIntoString:cardNumberWithoutSpaces
                      andPreserveCursorPosition:&targetCursorPosition];
    
    textField.text = cardNumberWithSpaces;
    UITextPosition *targetPosition =
    [textField positionFromPosition:[textField beginningOfDocument]
                             offset:targetCursorPosition];
    
    [textField setSelectedTextRange:
     [textField textRangeFromPosition:targetPosition
                           toPosition:targetPosition]
     ];
}

-(BOOL)textField:(UITextField *)textField
shouldChangeCharactersInRange:(NSRange)range
replacementString:(NSString *)string
{
    // Note textField's current state before performing the change, in case
    // reformatTextField wants to revert it
    self.previousTextFieldContent = textField.text;
    self.previousSelection = textField.selectedTextRange;
    
    return YES;
}

/*
 Removes non-digits from the string, decrementing `cursorPosition` as
 appropriate so that, for instance, if we pass in `@"1111 1123 1111"`
 and a cursor position of `8`, the cursor position will be changed to
 `7` (keeping it between the '2' and the '3' after the spaces are removed).
 */
- (NSString *)removeNonDigits:(NSString *)string
    andPreserveCursorPosition:(NSUInteger *)cursorPosition
{
    NSUInteger originalCursorPosition = *cursorPosition;
    NSMutableString *digitsOnlyString = [NSMutableString new];
    for (NSUInteger i=0; i<[string length]; i++) {
        unichar characterToAdd = [string characterAtIndex:i];
        if (isdigit(characterToAdd)) {
            NSString *stringToAdd =
            [NSString stringWithCharacters:&characterToAdd
                                    length:1];
            
            [digitsOnlyString appendString:stringToAdd];
        }
        else {
            if (i < originalCursorPosition) {
                (*cursorPosition)--;
            }
        }
    }
    
    return digitsOnlyString;
}

/*
 Inserts spaces into the string to format it as a credit card number,
 incrementing `cursorPosition` as appropriate so that, for instance, if we
 pass in `@"111111231111"` and a cursor position of `7`, the cursor position
 will be changed to `8` (keeping it between the '2' and the '3' after the
 spaces are added).
 */
- (NSString *)insertSpacesEveryFourDigitsIntoString:(NSString *)string
                          andPreserveCursorPosition:(NSUInteger *)cursorPosition
{
    NSMutableString *stringWithAddedSpaces = [NSMutableString new];
    NSUInteger cursorPositionInSpacelessString = *cursorPosition;
    for (NSUInteger i=0; i<[string length]; i++) {
        if ((i>0) && ((i % 4) == 0)) {
            [stringWithAddedSpaces appendString:@" "];
            if (i < cursorPositionInSpacelessString) {
                (*cursorPosition)++;
            }
        }
        unichar characterToAdd = [string characterAtIndex:i];
        NSString *stringToAdd =
        [NSString stringWithCharacters:&characterToAdd length:1];
        
        [stringWithAddedSpaces appendString:stringToAdd];
    }
    
    return stringWithAddedSpaces;
}

#pragma mark -

#pragma mark -

- (NSString *) modifyTextField:(UITextField *) textField
{
    [self reformatAsCardNumber:textField];
    [self.delegate setValue:textField.text];
    return textField.text;
}

@end
