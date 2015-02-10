//
//  AINFormCell.m
//  AINFormView
//
//  Created by chris nielubowicz on 1/23/15.
//  Copyright (c) 2015 Assorted Intelligence. All rights reserved.
//

#import "AINFormViewCell.h"

@interface AINFormViewCell () <UITextFieldDelegate>

@property (nonatomic, strong) ValidationBlock validationBlock;

@end

@implementation AINFormViewCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        _formInput = [[UITextField alloc] init];
        _formInput.userInteractionEnabled = YES;
        _formInput.borderStyle = UITextBorderStyleBezel;
        _formInput.placeholder = @"placeholder text";
        _formInput.returnKeyType = UIReturnKeyDone;
        [self.contentView addSubview:_formInput];
        
        self.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    return self;
}

- (void)layoutSubviews
{
    self.formInput.frame = self.contentView.bounds;

    // redraw validation icon given the result of the validation block
    [self validateInput];
}

-(BOOL)validateInput;
{
    BOOL inputIsValid = YES;
    if (self.validationBlock != nil) {
        inputIsValid = self.validationBlock(self.formInput.text);
    }
    return inputIsValid;
}

@end
