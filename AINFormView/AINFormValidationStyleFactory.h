//
//  AINFormValidationStyleFactory.h
//  AINFormView
//
//  Created by chris nielubowicz on 4/15/15.
//  Copyright (c) 2015 Assorted Intelligence. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "AINFormValidationDisplay.h"

@interface AINFormValidationStyleFactory : NSObject

+ (AINFormValidationDisplay *)validationDisplayForValidationStyle:(AINFormValidationStyle)validationStyle withTextField:(UITextField *)formInput;

@end
