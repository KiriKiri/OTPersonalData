
//
//  OTPersonalDataTableFinalFooterView.m
//  OTPersonalDataControl
//
//  Created by KiriKiri on 20.03.14.
//  Copyright (c) 2014 Seductive. All rights reserved.
//

#import "OTPersonalDataTableFinalFooterView.h"

@implementation OTPersonalDataTableFinalFooterView

- (void) awakeFromNib
{
    [super awakeFromNib];
    [self.sendButton.titleLabel setFont:[UIFont systemFontOfSize:21.0]];
    [self.sendButton setTitle:NSLocalizedString(@"Send Data", nil) forState:UIControlStateNormal];
}

@end
