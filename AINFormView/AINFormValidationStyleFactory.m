//
//  AINFormValidationStyleFactory.m
//  AINFormView
//
//  Created by chris nielubowicz on 4/15/15.
//  Copyright (c) 2015 Assorted Intelligence. All rights reserved.
//

#import "AINFormValidationStyleFactory.h"
#import "AINFormValidationOutline.h"
#import "AINFormValidationAccessoryIcon.h"

@implementation AINFormValidationStyleFactory

+ (AINFormValidationDisplay *)validationDisplayForValidationStyle:(AINFormValidationStyle)validationStyle withTextField:(UITextField *)formInput
{
    AINFormValidationDisplay *validationDecorator = nil;
    switch (validationStyle) {
        case AINFormValidationStyleOutlined: {
            validationDecorator = [[AINFormValidationOutline alloc] initWithTextField:formInput];
        }
            break;
        case AINFormValidationStyleAccessoryIcon: {
            validationDecorator = [[AINFormValidationAccessoryIcon alloc] initWithTextField:formInput];
        }
        default:
            break;
    }
    
    return validationDecorator;
}

@end
