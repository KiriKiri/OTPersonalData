//
//  OTPersonalDataTableViewCell.m
//  OTPersonalDataControl
//
//  Created by KiriKiri on 19.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import "OTPersonalDataTableViewCell.h"

@interface OTPersonalDataTableViewCell() <UITextFieldDelegate>
@property (nonatomic, strong) id<OTModifierInputViewProtocol> inputView;
@end

@implementation OTPersonalDataTableViewCell
@synthesize isValid = _isValid;

- (void) setModifierDelegate:(id<OTModifierProtocol>)modifierDelegate
{
    _modifierDelegate = modifierDelegate;
    [_modifierDelegate initTextField:self.valueTextField];
    
    if ([_modifierDelegate respondsToSelector:@selector(inputView)]) {
        self.inputView = [_modifierDelegate inputView];
        [self.inputView setTextField:self.valueTextField];
        
    } else {
        self.inputView = nil;
        self.valueTextField.inputView = nil;
    }
}

- (void) didReceiveModifyTextFieldNotification:(NSNotification *) notification
{
    NSString *value = [[notification userInfo] objectForKey:@"value"];
    self.valueTextField.text = value;
}

- (void) textFieldDidChange:(UITextField *)sender
{
    [self.modifierDelegate textFieldDidChange:sender];
}

- (void)awakeFromNib
{
    self.valueTextField.delegate = self;
    [self.valueTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
}

- (void) setDescriptionHidden:(BOOL)descriptionHidden
{
    _descriptionHidden = descriptionHidden;
    if (self.descriptionHidden) {
        self.descriptionLabel.hidden = YES;
        self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, 31);
    } else {
        self.descriptionLabel.hidden = NO;
        self.titleLabel.frame = CGRectMake(self.titleLabel.frame.origin.x, self.titleLabel.frame.origin.y, self.titleLabel.frame.size.width, 21);
    }
}

- (void) setIsValid:(BOOL)isValid
{
    _isValid = isValid;
    if (isValid) {
        self.backgroundColor = [UIColor whiteColor];
    } else {
        self.backgroundColor = [UIColor redColor];
    }
}

- (BOOL) isValid
{
    return _isValid;
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    if (self.modifierDelegate) {
        return [self.modifierDelegate textFieldShouldReturn:textField];
    }
    
    [textField resignFirstResponder];
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if (self.modifierDelegate) {
        return [self.modifierDelegate textFieldShouldBeginEditing:textField];
    }
    return YES;
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (self.modifierDelegate) {
        return [self.modifierDelegate textField:textField shouldChangeCharactersInRange:range replacementString:string];
    }
    
    return YES;
}

#pragma mark -

@end
