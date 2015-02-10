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

@end

@implementation AINFormView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.dataSource = self;
        self.delegate = self;

        // Initialization code
        self.scrollEnabled = NO;
        self.backgroundView = nil;
        self.backgroundColor = [UIColor lightTextColor];
        
        self.layer.borderColor = [UIColor yellowColor].CGColor;
        self.layer.borderWidth = 1.f;
        
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillAppear:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillDisappear:) name:UIKeyboardWillHideNotification object:nil];
        
    }
    return self;
}
#pragma mark UITableViewDataSource methods
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 88;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 7;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    AINFormViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"FormCell"];
    if (cell == nil) {
        cell = [[AINFormViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"FormCell"];
    }
    
    cell.formInput.delegate = self;
    cell.formInput.placeholder = [NSString stringWithFormat:@"Placeholder #%@", @(indexPath.row + 1)];
    return cell;
}

#pragma mark - UITableViewDelegate methods



#pragma mark - UIKeyboardNotifications
- (void)keyboardWillAppear:(NSNotification *)notification
{
    NSValue *beginFrameValue = notification.userInfo[UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardBeginFrame = [self convertRect:beginFrameValue.CGRectValue fromView:nil];
    
    NSValue *endFrameValue = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardEndFrame = [self convertRect:endFrameValue.CGRectValue fromView:nil];

    NSLog(@"%s: %@", __PRETTY_FUNCTION__, notification);
    
    CGRect tableViewFrame = self.frame;
    tableViewFrame.size.height = (keyboardBeginFrame.origin.y - tableViewFrame.origin.y);
    self.frame = tableViewFrame;
    
    [UIView animateWithDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                          delay:0.0
                        options:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]
                     animations:^{
                         CGRect tableViewFrame = self.frame;
                             tableViewFrame.size.height = (keyboardEndFrame.origin.y - tableViewFrame.origin.y);
                             self.frame = tableViewFrame;
                     } completion:^(BOOL finished) {
                         
                     }];
}

- (void)keyboardWillDisappear:(NSNotification *)notification
{
    NSLog(@"%s: %@", __PRETTY_FUNCTION__, notification);
    
    NSValue *endFrameValue = notification.userInfo[UIKeyboardFrameEndUserInfoKey];
    CGRect keyboardEndFrame = [self convertRect:endFrameValue.CGRectValue fromView:nil];

    [UIView animateWithDuration:[notification.userInfo[UIKeyboardAnimationDurationUserInfoKey] doubleValue]
                          delay:0.0
                        options:[notification.userInfo[UIKeyboardAnimationCurveUserInfoKey] integerValue]
                     animations:^{
                         CGRect tableViewFrame = self.frame;
                         tableViewFrame.size.height = (keyboardEndFrame.origin.y);
                         self.frame = tableViewFrame;
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

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    NSLog(@"%s %@ not implemented", __PRETTY_FUNCTION__, textField.placeholder);
}

- (BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    NSLog(@"%s %@ not implemented", __PRETTY_FUNCTION__, textField.placeholder);    // save this somehow ??

    BOOL textIsValid = YES;
    // validate text, return the result
    NSIndexPath *textFieldIndexPath = [self indexPathForTextField:textField];
    AINFormViewCell *cell = (AINFormViewCell *)[self tableView:self cellForRowAtIndexPath:textFieldIndexPath];
    textIsValid = [cell validateInput];
    return textIsValid;
}

- (void)textFieldDidEndEditing:(UITextField *)textField
{
    NSLog(@"%s %@ not implemented", __PRETTY_FUNCTION__, textField.placeholder);    // save this somehow ??
    // the state will need to persist so that the next time this view comes up, the info is still present
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    NSIndexPath *textFieldIndexPath = [self indexPathForTextField:textField];
    NSIndexPath *nextTextFieldIndexPath = [NSIndexPath indexPathForRow:textFieldIndexPath.row + 1 inSection:textFieldIndexPath.section];
    
    AINFormViewCell *nextCell = (AINFormViewCell *)[self tableView:self cellForRowAtIndexPath:nextTextFieldIndexPath];
    if (nextCell != nil) {
        [self scrollToRowAtIndexPath:nextTextFieldIndexPath
                    atScrollPosition:UITableViewScrollPositionBottom animated:YES];
        BOOL result = [textField resignFirstResponder];
        result = [nextCell.formInput becomeFirstResponder];
        
        NSLog(@"");
    }
    
    return NO;
}
@end
