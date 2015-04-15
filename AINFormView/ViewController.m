//
//  ViewController.m
//  AINFormView
//
//  Created by chris nielubowicz on 1/23/15.
//  Copyright (c) 2015 Assorted Intelligence. All rights reserved.
//

#import "ViewController.h"
#import "AINFormView.h"
#import "AINFormViewCell.h"

@interface ViewController () <AINFormViewDataSouce, AINFormViewDelegate>

@property (nonatomic, strong) NSArray *placeholderArray;

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    
    AINFormView *formView = [[AINFormView alloc] initWithFrame:self.view.bounds];
    formView.formDataSource = self;
    formView.formDelegate = self;
    [self.view addSubview:formView];
    
    self.placeholderArray = @[@"Name", @"Email Address", @"Astrological Sign", @"Worst Fear", @"Zipcode"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - AINFormViewDataSource

- (NSString *)formView:(AINFormView *)formView placeholderLabelTextForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.placeholderArray[indexPath.row];
}

- (NSInteger)formView:(AINFormView *)formView numberOfRowsInSection:(NSInteger)section
{
    return self.placeholderArray.count;
}


#pragma mark - AINFormViewDelegate

-(void)formView:(AINFormView *)formView didFinishWithFormInfo:(NSDictionary *)formInfo forSection:(NSInteger)formSection;
{
    NSLog(@"%s:%d %@", __PRETTY_FUNCTION__, formSection, formInfo);
}

- (void)formView:(AINFormView *)formView willDisplayCell:(AINFormViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%s", __PRETTY_FUNCTION__);
}
@end
