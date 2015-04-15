//
//  AINFormCell.m
//  AINFormView
//
//  Created by chris nielubowicz on 1/23/15.
//  Copyright (c) 2015 Assorted Intelligence. All rights reserved.
//

#import "AINFormViewCell.h"
#import "AINFormValidationDisplay.h"
#import "AINFormValidationStyleFactory.h"

@interface AINFormViewCell () <UITextFieldDelegate>

@property (assign,nonatomic) AINFormValidationState isValid;

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
        self.validationStyle = AINFormValidationStyleOutlined;
    }
    
    return self;
}

- (void)layoutSubviews
{
    self.formInput.frame = self.contentView.bounds;
    if (self.formInput.text.length > 0) {
        [self validateInput];
    }
}

- (void)prepareForReuse
{
    self.isValid = AINFormValidationNotValidated;
}

-(BOOL)validateInput;
{
    BOOL inputIsValid = YES;
    if (self.validationBlock != nil) {
        inputIsValid = self.validationBlock(self.formInput.text);
        if (inputIsValid) {
            self.isValid = AINFormValidationIsValid;
        } else {
            self.isValid = AINFormValidationIsInvalid;
        }
    }
    return inputIsValid;
}

- (void)setValidationStyle:(AINFormValidationStyle)validationStyle
{
    _validationStyle = validationStyle;
    self.validationDisplay = [AINFormValidationStyleFactory validationDisplayForValidationStyle:self.validationStyle withTextField:self.formInput];
}

-(void)setIsValid:(AINFormValidationState)isValid
{
    _isValid = isValid;
    [self.validationDisplay configureForValidationState:self.isValid];
}

-(void)setEditing:(BOOL)editing
{
    if (editing) {
        [self.formInput becomeFirstResponder];
    }
    else {
        [self.formInput resignFirstResponder];
    }
}

@end
