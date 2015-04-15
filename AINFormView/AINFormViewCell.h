//
//  AINFormCell.h
//  AINFormView
//
//  Created by chris nielubowicz on 1/23/15.
//  Copyright (c) 2015 Assorted Intelligence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AINFormValidationDisplay;

@interface AINFormViewCell : UITableViewCell

/* @enum AINFormValidationState
 *  @value AINFormValidationNotValidated    No validation has been performed yet. usually indicates content length of 0.
 *  @value AINFormValidationIsInvalid       Input is not valid according to the validationBlock provided.
 *  @value AINFormValidationValid           Input is valid according to the validationBlock provided.
 */
typedef NS_ENUM(NSUInteger, AINFormValidationState) {
    AINFormValidationNotValidated,
    AINFormValidationIsInvalid,
    AINFormValidationIsValid,
};

/* @enum AINFormValidationStyle
 *  @value AINFormValidationOutlined        Sets the border color to green for valid input and red for invalid input
 *  @value AINFormValidationAccessoryIcon   Sets the accessory view to a green circle for valid input and a red circle for invalid input
 */
typedef NS_ENUM(NSUInteger, AINFormValidationStyle) {
    AINFormValidationStyleOutlined,
    AINFormValidationStyleAccessoryIcon,
    AINFormValidationStyleCustom,
};

typedef BOOL(^AINFormValidationBlock)(NSString *textToValidate);

@property (nonatomic, strong) UITextField *formInput;

/* Block to validate text. 
 *  @discussion
 *      Return value determines the configuration of validationDisplay. Set to NULL for no validation (or validation display).
 */
@property (nonatomic, strong) AINFormValidationBlock validationBlock;

/* AINFormValidationStyle style for this cell.
 *  @discussion
 *      AINFormValidationStyleOutlined is the default AINFormValidationStyle value. If set to AINFormValidationStyleCustom, the AINFormCell expects
 *      a custom AINFormValidationDisplay to be provided via the validationDisplay property.
 */
@property (nonatomic, assign) AINFormValidationStyle validationStyle;

/* AINFormValidationDisplay configuration for this cell
 *  @discussion
 *      Subclasses of AINFormValidationDisplay implement configureForValidationState: to determine the configuration of the cell based on the AINFormValidationState provided.
 *      For example, the default behavior, AINFormValidationStyleOutlined, sets the border color of invalid input to red and the border color of valid input to green.
 */
@property (nonatomic, strong) AINFormValidationDisplay *validationDisplay;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier;
- (BOOL)validateInput;

@end
