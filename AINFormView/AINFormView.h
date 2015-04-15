//
//  AINFormView.h
//  AINFormView
//
//  Created by chris nielubowicz on 1/23/15.
//  Copyright (c) 2015 Assorted Intelligence. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol AINFormViewDataSouce;
@protocol AINFormViewDelegate;

@interface AINFormView : UITableView

@property (nonatomic, weak) id<AINFormViewDataSouce>formDataSource;
@property (nonatomic, weak) id<AINFormViewDelegate>formDelegate;

@end

@protocol AINFormViewDataSouce <NSObject>

@required

-(NSInteger)formView:(AINFormView *)formView numberOfRowsInSection:(NSInteger)formSection;
-(NSString *)formView:(AINFormView *)formView placeholderLabelTextForRowAtIndexPath:(NSIndexPath *)indexPath;

@optional

-(NSInteger)numberOfSectionsInFormView:(AINFormView *)formView;
-(NSString *)formView:(AINFormView *)formView sectionTitleForSection:(NSInteger)formSection;
-(UIView *)formView:(AINFormView *)formView headerViewForSection:(NSInteger)formSection;
-(UIView *)formView:(AINFormView *)formView footerViewForSection:(NSInteger)formSection;
-(UITextField *)formView:(AINFormView *)formView textFieldForRowAtIndexPath:(NSIndexPath *)indexPath;

@end

@protocol AINFormViewDelegate <NSObject>

@required

-(void)formView:(AINFormView *)formView didFinishWithFormInfo:(NSDictionary *)formInfo forSection:(NSInteger)formSection;

@end