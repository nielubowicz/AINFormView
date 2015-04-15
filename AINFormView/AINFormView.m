//
//  AINFormView.m
//  AINFormView
//
//  Created by chris nielubowicz on 1/23/15.
//  Copyright (c) 2015 Assorted Intelligence. All rights reserved.
//

#import "AINFormView.h"
#import "AINFormViewCell.h"

@interface AINFormView () <UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate>

@property (nonatomic,strong) NSIndexPath *editingIndexPath;
@property (nonatomic,strong) NSIndexPath *desiredEditingIndexPath;

@property (nonatomic,strong) NSMutableDictionary *formInfo;

@end

@implementation AINFormView

static NSString *const AINFormCellReuseIdentifier = @"AINFormCell";

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;

        self.backgroundView = nil;
        self.backgroundColor = [UIColor lightTextColor];
        
        self.formInfo = [NSMutableDictionary dictionary];
        [self registerKeyboardObservers];
    }
    return self;
}

- (void)registerKeyboardObservers
{
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
}

- (void)removeKeyboardObservers
{
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

#pragma mark UITableViewDataSource methods

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSInteger sections = 1;
    if (self.formDataSource && [self.formDataSource respondsToSelector:@selector(numberOfSectionsInFormView:)]) {
        sections = [self.formDataSource numberOfSectionsInFormView:self];
    }
    
    return sections;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [self.formDataSource formView:self numberOfRowsInSection:section];
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AINFormViewCell *cell = [tableView dequeueReusableCellWithIdentifier:AINFormCellReuseIdentifier];
    if (cell == nil) {
        cell = [[AINFormViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:AINFormCellReuseIdentifier];
    }
    
    if (self.formDataSource && [self.formDataSource respondsToSelector:@selector(formView:textFieldForRowAtIndexPath:)]) {
        cell.formInput = [self.formDataSource formView:self textFieldForRowAtIndexPath:indexPath];
    }
    
    cell.formInput.placeholder = [self.formDataSource formView:self placeholderLabelTextForRowAtIndexPath:indexPath];
    cell.formInput.delegate = self;

    if (self.formInfo[cell.formInput.placeholder]) {
        cell.formInput.text = self.formInfo[cell.formInput.placeholder];
    } else {
        cell.formInput.text = @"";
    }
    
    if (indexPath.row == 0) {
        cell.validationBlock = ^BOOL(NSString *textToValidate) {
            
            BOOL isValid = NO;
            if (textToValidate.length > 0) {
                isValid = YES;
            }
            return isValid;
        };
    } else {
        cell.validationBlock = NULL;
    }
    
    if (self.formDelegate && [self.formDelegate respondsToSelector:@selector(formView:willDisplayCell:forRowAtIndexPath:)]) {
        [self.formDelegate formView:self willDisplayCell:cell forRowAtIndexPath:indexPath];
    }
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    NSString *title = nil;
    if (self.formDataSource && [self.formDataSource respondsToSelector:@selector(formView:sectionTitleForSection:)]) {
        title = [self.formDataSource formView:self sectionTitleForSection:section];
    }
    
    return title;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *headerView = nil;
    if (self.formDataSource && [self.formDataSource respondsToSelector:@selector(formView:headerViewForSection:)]) {
        headerView = [self.formDataSource formView:self headerViewForSection:section];
    }
    
    return headerView;
}

- (UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    UIView *footerView = nil;
    if (self.formDataSource && [self.formDataSource respondsToSelector:@selector(formView:footerViewForSection:)]) {
        footerView = [self.formDataSource formView:self footerViewForSection:section];
    }
    
    return footerView;
}

#pragma mark - UITableViewDelegate methods

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}


#pragma mark - UIKeyboardNotifications
- (void)keyboardWillAppear:(NSNotification *)notification
{
    NSValue *endFrameValue = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardEndFrame = [self convertRect:endFrameValue.CGRectValue fromView:nil];

    [UIView animateWithDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                          delay:0.0
                        options:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16
                     animations:^{
                         CGRect tableViewFrame = self.frame;
                         tableViewFrame.size.height = (tableViewFrame.size.height - keyboardEndFrame.size.height);
                         self.frame = tableViewFrame;
                     } completion:^(BOOL finished) {

                     }];
}

- (void)keyboardWillDisappear:(NSNotification *)notification
{
    NSValue *beginFrameValue = notification.userInfo[UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardBeginFrame = [self convertRect:beginFrameValue.CGRectValue fromView:nil];

    [UIView animateWithDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                          delay:0.0
                        options:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue] << 16
                     animations:^{
                         CGRect tableViewFrame = self.frame;
                         tableViewFrame.size.height = (tableViewFrame.size.height + keyboardBeginFrame.size.height);
                         self.frame = tableViewFrame;
                         [self scrollToRowAtIndexPath:self.editingIndexPath
                                     atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                     } completion:^(BOOL finished) {

                     }];
}


#pragma mark - UITextFieldDelegate methods

- (NSIndexPath *)indexPathForTextField:(UITextField *)textField
{
    CGPoint center = textField.center;
    CGPoint centerInView = [self convertPoint:center fromView:textField];
    return [self indexPathForRowAtPoint:centerInView];
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField;        // return NO to disallow editing.
{
    self.desiredEditingIndexPath = [self indexPathForTextField:textField];
    return YES;
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    self.desiredEditingIndexPath = nil;
    self.editingIndexPath = [self indexPathForTextField:textField];
    
    NSInteger rows = [self numberOfRowsInSection:self.editingIndexPath.section];
    if (self.editingIndexPath.row < rows - 1) {
        textField.returnKeyType = UIReturnKeyNext;
    } else {
        textField.returnKeyType = UIReturnKeyDone;
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if (textField.text.length > 0) {
        AINFormViewCell *textCell = (AINFormViewCell *)[self cellForRowAtIndexPath:self.editingIndexPath];
        // cell is offscreen
        if (textCell == nil) {
            [self scrollToRowAtIndexPath:self.editingIndexPath
                        atScrollPosition:UITableViewScrollPositionBottom animated:NO];
            textCell = (AINFormViewCell *)[self cellForRowAtIndexPath:self.editingIndexPath];
        }
        [textCell validateInput];
    }
    
    return YES;
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    AINFormViewCell *textCell = (AINFormViewCell *)[self cellForRowAtIndexPath:self.editingIndexPath];
    // cell is offscreen
    if (textCell == nil) {
        [self scrollToRowAtIndexPath:self.editingIndexPath
                    atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        textCell = (AINFormViewCell *)[self cellForRowAtIndexPath:self.editingIndexPath];
    }
    return [textCell validateInput];
}

/* @discussion
 *  Save form data for this field. Data is guaranteed to be valid according to the rules defined
 *  in the container AINFormViewCell's validationBlock. Returns formInfo on completion of each section
 */
- (void)textFieldDidEndEditing:(UITextField *)textField
{
    self.formInfo[textField.placeholder] = textField.text;
    NSInteger rows = [self numberOfRowsInSection:self.editingIndexPath.section];
    if (self.editingIndexPath.row == rows - 1) {
        [self.formDelegate formView:self didFinishWithFormInfo:[self.formInfo copy] forSection:self.editingIndexPath.section];
    } else if (self.desiredEditingIndexPath != nil) {
        [self scrollToRowAtIndexPath:self.desiredEditingIndexPath
                    atScrollPosition:UITableViewScrollPositionBottom animated:NO];
        AINFormViewCell *textCell = (AINFormViewCell *)[self cellForRowAtIndexPath:self.desiredEditingIndexPath];
        [textCell.formInput becomeFirstResponder];
        self.desiredEditingIndexPath = nil;
    }
    self.editingIndexPath = nil;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSIndexPath *textFieldIndexPath = self.editingIndexPath;
    NSIndexPath *nextTextFieldIndexPath = [NSIndexPath indexPathForRow:textFieldIndexPath.row + 1 inSection:textFieldIndexPath.section];
    
    AINFormViewCell *textCell = (AINFormViewCell *)[self cellForRowAtIndexPath:textFieldIndexPath];
    if (nextTextFieldIndexPath.section < [self numberOfSections] && nextTextFieldIndexPath.row < [self numberOfRowsInSection:nextTextFieldIndexPath.section]) {
        if ([textCell validateInput]) {
            [self removeKeyboardObservers];
            [UIView animateWithDuration:0.15
                             animations:^{
                                 [self scrollToRowAtIndexPath:nextTextFieldIndexPath
                                             atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                             } completion:^(BOOL finished) {
                                 [textCell setEditing:NO];
                                 
                                 AINFormViewCell *nextCell = (AINFormViewCell *)[self cellForRowAtIndexPath:nextTextFieldIndexPath];
                                 [nextCell setEditing:YES];
                                 [self registerKeyboardObservers];
                             }];
        } else {
            [textCell setNeedsLayout];

            // cell is offscreen
            if (textCell == nil) {
                [self scrollToRowAtIndexPath:nextTextFieldIndexPath
                            atScrollPosition:UITableViewScrollPositionBottom animated:NO];
                AINFormViewCell *nextCell = (AINFormViewCell *)[self cellForRowAtIndexPath:nextTextFieldIndexPath];
                [nextCell setEditing:YES];
            }
        }
    } else {
        [textCell setEditing:NO];
    }
    
    return NO;
}
@end
