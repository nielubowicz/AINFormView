//
//  AINFormView.h
//  AINFormView
//
//  Created by chris nielubowicz on 1/23/15.
//  Copyright (c) 2015 Assorted Intelligence. All rights reserved.
//

#import <UIKit/UIKit.h>

@class AINFormView;

@protocol AINFormViewDataSouce <NSObject>

@required

-(NSInteger)formView:(AINFormView *)formView numberOfRowsInSection:(NSInteger)section;

@end

@protocol AINFormViewDelegate <NSObject>


@end

@interface AINFormView : UITableView

@property (nonatomic, weak) id<AINFormViewDataSouce>formDataSource;
@property (nonatomic, weak) id<AINFormViewDelegate>formDelegate;

@end
