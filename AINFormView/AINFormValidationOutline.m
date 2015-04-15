//
//  AINFormValidationOutline.m
//  AINFormView
//
//  Created by chris nielubowicz on 4/15/15.
//  Copyright (c) 2015 Assorted Intelligence. All rights reserved.
//

#import "AINFormValidationOutline.h"

@implementation AINFormValidationOutline

- (void)configureForValidationState:(AINFormValidationState)isValid
{
    if (isValid == AINFormValidationIsValid) {
        self.fieldToValidate.layer.borderColor = [UIColor greenColor].CGColor;
        self.fieldToValidate.layer.borderWidth = 2.f;
    } else if (isValid == AINFormValidationIsInvalid) {
        self.fieldToValidate.layer.borderColor = [UIColor redColor].CGColor;
        self.fieldToValidate.layer.borderWidth = 2.f;
    } else if (isValid == AINFormValidationNotValidated) {
        self.fieldToValidate.layer.borderColor = [UIColor blackColor].CGColor;
        self.fieldToValidate.layer.borderWidth = 0.f;
    }
    
    [self.fieldToValidate setNeedsDisplay];
}

@end
