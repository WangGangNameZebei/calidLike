//
//  CustomActionSheet.h
//  claidApp
//
//  Created by kevinpc on 2016/10/18.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "BaseView.h"

@interface CustomActionSheet : BaseView<UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UIView *msskView;
@property (weak, nonatomic) IBOutlet UITableView *actionSheetTableView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewHeightConstraint;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *tableViewButtonConstraint;

@property(weak, nonatomic) id<UITableViewDelegate> delegate;
- (void)setItem:(NSInteger)item Color:(UIColor *)color;
- (void)setup;
- (void)setTexts:(NSArray *)array;
- (void)show;
- (void)hide;
@end
