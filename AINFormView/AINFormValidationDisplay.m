//
//  AINFormValidationDisplay.m
//  AINFormView
//
//  Created by chris nielubowicz on 4/15/15.
//  Copyright (c) 2015 Assorted Intelligence. All rights reserved.
//

#import "AINFormValidationDisplay.h"

@interface AINFormValidationDisplay ()

@end

@implementation AINFormValidationDisplay

- (instancetype)initWithTextField:(UITextField *)fieldToValidate
{
    if (self = [super init]) {
        _fieldToValidate = fieldToValidate;
    }
    return self;
}

- (void)configureForValidationState:(AINFormValidationState)isValid
{
    // Default implementation does nothing. Sub-classes should override this method to change display
}

@end
