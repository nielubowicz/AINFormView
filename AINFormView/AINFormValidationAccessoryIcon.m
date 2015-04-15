//
//  AINFormValidationAccessoryIcon.m
//  AINFormView
//
//  Created by chris nielubowicz on 4/15/15.
//  Copyright (c) 2015 Assorted Intelligence. All rights reserved.
//

#import "AINFormValidationAccessoryIcon.h"

@implementation AINFormValidationAccessoryIcon

- (void)configureForValidationState:(AINFormValidationState)isValid
{
    if (self.fieldToValidate.rightView == nil) {
        self.fieldToValidate.rightView = [UIView new];
        self.fieldToValidate.rightView.bounds = CGRectMake(0, 0, 44, 44);
        self.fieldToValidate.rightView.layer.cornerRadius = self.fieldToValidate.rightView.bounds.size.width / 2.f;
    }
    
    if (isValid == AINFormValidationIsValid) {
        self.fieldToValidate.rightViewMode = UITextFieldViewModeAlways;
        self.fieldToValidate.rightView.backgroundColor = [UIColor greenColor];
    } else if (isValid == AINFormValidationIsInvalid) {
        self.fieldToValidate.rightViewMode = UITextFieldViewModeAlways;
        self.fieldToValidate.rightView.backgroundColor = [UIColor redColor];
    } else if (isValid == AINFormValidationNotValidated) {
        self.fieldToValidate.rightViewMode = UITextFieldViewModeNever;
    }
    
    [self.fieldToValidate setNeedsDisplay];
}

@end
