//
//  AINFormValidationDisplay.h
//  AINFormView
//
//  Created by chris nielubowicz on 4/15/15.
//  Copyright (c) 2015 Assorted Intelligence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AINFormViewCell.h"

@interface AINFormValidationDisplay : NSObject

@property (weak, nonatomic) UITextField *fieldToValidate;

- (instancetype)initWithTextField:(UITextField *)fieldToValidate;
- (void)configureForValidationState:(AINFormValidationState)isValid;

@end
