//
//  OTPersonalDataTableViewCell.h
//  OTPersonalDataControl
//
//  Created by KiriKiri on 19.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTBaseModifier.h"

@interface OTPersonalDataTableViewCell : UITableViewCell //<UIPickerViewDataSource, UIPickerViewDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;
@property (weak, nonatomic) IBOutlet UITextField *valueTextField;
@property (weak, nonatomic) id <OTModifierProtocol> modifierDelegate;

@property (nonatomic) BOOL isValid;
@property (nonatomic) BOOL descriptionHidden;
@end
