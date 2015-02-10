//
//  AINFormCell.h
//  AINFormView
//
//  Created by chris nielubowicz on 1/23/15.
//  Copyright (c) 2015 Assorted Intelligence. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AINFormViewCell : UITableViewCell

typedef BOOL(^ValidationBlock)(NSString *textToValidate);

@property (nonatomic, strong) UITextField *formInput;

-(BOOL)validateInput;

@end
