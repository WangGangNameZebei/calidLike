//
//  CustomActionSheet.m
//  claidApp
//
//  Created by kevinpc on 2016/10/18.
//  Copyright © 2016年 kevinpc. All rights reserved.
//

#import "CustomActionSheet.h"
#import "CustomActionSheetCell.h"
#import "UIColor+Utility.h"

@interface CustomActionSheet()
@property (strong, nonatomic) UIColor *color;
@property (assign, nonatomic) NSInteger item;
@property (strong, nonatomic) NSArray *texts;
@end

@implementation CustomActionSheet

+ (instancetype)create {
    CustomActionSheet *customActionSheet = [[[NSBundle mainBundle] loadNibNamed:@"CustomActionSheet" owner:nil options:nil] lastObject];
    return customActionSheet;
}

- (void)setup {
    self.hidden = YES;
    self.actionSheetTableView.transform = CGAffineTransformMakeScale(1, -1);
    self.actionSheetTableView.delegate = self.delegate;
    [self.actionSheetTableView registerNib:[UINib nibWithNibName:CUSTOM_ACTIONSHEET_TABLEVIEW_VELL_NIBNAME bundle:nil] forCellReuseIdentifier:CUSTOM_ACTIONSHEET_TABLEVIEW_VELL_ID];
    self.actionSheetTableView.dataSource = self;
    self.maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    for (UIGestureRecognizer *gesture in self.maskView.gestureRecognizers) {
        [self.maskView removeGestureRecognizer:gesture];
    }
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)];
    [self.maskView addGestureRecognizer:tap];
}

- (void)show {
    self.hidden = NO;
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:2 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.tableViewButtonConstraint.constant = 0;
        [self layoutIfNeeded];
    } completion:nil];
    [UIView animateWithDuration:0.2 animations:^{
        self.maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0.5];
    }];
}

- (void)hide {
    [UIView animateWithDuration:0.2 delay:0 usingSpringWithDamping:2 initialSpringVelocity:5.0 options:UIViewAnimationOptionCurveLinear animations:^{
        self.tableViewButtonConstraint.constant = -self.actionSheetTableView.contentSize.height;
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        self.hidden = YES;
    }];
    [UIView animateWithDuration:0.2 animations:^{
        self.maskView.backgroundColor = [UIColor colorWithRed:0 green:0 blue:0 alpha:0];
    }];
}

- (void)setTexts:(NSArray *)array {
    _texts = array;
    CGFloat cellHeight = 0;
    if (array.count > 0 && [self.delegate respondsToSelector:@selector(tableView:heightForRowAtIndexPath:)]) {
        cellHeight = [self.delegate tableView:self.actionSheetTableView heightForRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0]];
    }
    self.tableViewButtonConstraint.constant = - cellHeight * (array.count + 1);
    self.tableViewHeightConstraint.constant = cellHeight * (array.count + 1);
    [self layoutIfNeeded];
    [self.actionSheetTableView reloadData];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.texts.count + 1;
}

- (void)setItem:(NSInteger)item Color:(UIColor *)color {
    self.color = color;
    self.item = item;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    CustomActionSheetCell *cell = [[[NSBundle mainBundle] loadNibNamed:CUSTOM_ACTIONSHEET_TABLEVIEW_VELL_NIBNAME owner:nil options:nil] lastObject];
    cell.transform = CGAffineTransformMakeScale(1, -1);
    if (indexPath.item == 0) {
        [cell updateWithContentText:NSLocalizedString(@"custom-actionsheet-cancel", nil) color:[UIColor grayColor]];
    } else {
        UIColor *color = indexPath.item == self.item ? self.color :[UIColor colorWithRed:35.0 / 255.0 green:131.0 / 255.0 blue:250.0 /255.0 alpha:1.0];
        [cell updateWithContentText:[self.texts objectAtIndex:indexPath.item - 1] color:color];
        
    }
    
    return cell;
}

@end
