//
//  AnnouncementViewController+Configuration.m
//  claidApp
//
//  Created by Zebei on 2017/12/16.
//  Copyright © 2017年 kevinpc. All rights reserved.
//

#import "AnnouncementViewController+Configuration.h"
#import "AnnouncementViewController+LogicalFlow.h"
#import "UIScreen+Utility.h"
#import "UIView+DSCategory.h"

@implementation AnnouncementViewController (Configuration)

- (void)configureViews {
    
     [self announcementTableViewEdit];
     [self initDSImageBrowseView];
     [self announcementsetPOSTDataAction:1];
}

- (void)announcementTableViewEdit {
    self.hasNextPage = 1;
    self.layouts = [NSMutableArray array];
    self.announcementTableView.delegate = self;
    self.announcementTableView.dataSource = self;
    [self.announcementTableView showEmptyViewWithType:NoContentTypeOrder];
    __weak typeof(self) weakSelf = self;
    self.announcementTableView.mj_header = [MJRefreshNormalHeader headerWithRefreshingBlock:^{
        //刷新时候，需要执行的代码。一般是请求最新数据，请求成功之后，刷新列表
        [weakSelf loadNewData];
    }];
    self.announcementTableView.mj_footer = [MJRefreshBackNormalFooter footerWithRefreshingBlock:^{
        //刷新时候，需要执行的代码。一般是请求更多数据，请求成功之后，刷新列表
        [weakSelf loadNoreData];
    }];
    self.announcementTableView.noContentViewTapedBlock = ^{
        [weakSelf.indicator startAnimating];
        [weakSelf loadNewData];
    };
   
}
#pragma mark- MJRefresh delegate
- (void)loadNewData {
    self.mjBool = YES;
    [self announcementsetPOSTDataAction:1];
}
- (void)loadNoreData{
    self.mjBool = NO;
    if (self.hasNextPage != 0 && self.layouts.count > 0){
        [self announcementsetPOSTDataAction:self.pageNum + 1];
    } else {
        [self promptInformationActionWarningString:@"没有更多的数据了"];
        [self.announcementTableView.mj_footer endRefreshing];
    }
  
}

- (void)initDSImageBrowseView {
    self.indicator = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhiteLarge];
    self.indicator.size = CGSizeMake(80, 80);
    self.indicator.center = CGPointMake([UIScreen screenWidth] / 2, [UIScreen screenHeight] / 2);
    self.indicator.backgroundColor = [UIColor colorWithWhite:0.000 alpha:0.670];
    self.indicator.clipsToBounds = YES;
    self.indicator.layer.cornerRadius = 6;
    [self.indicator startAnimating];
    [self.view addSubview:self.indicator];
    
}


- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return ((DSDemoLayout *)self.layouts[indexPath.row]).cellHeight;
}

- (BOOL)tableView:(UITableView *)tableView shouldHighlightRowAtIndexPath:(NSIndexPath *)indexPath {
    return NO;
}



- (void)present:(DSImageBrowseView *)imageView index:(NSInteger)index{
    UIView *fromView = nil;
    NSMutableArray *items = [NSMutableArray array];
    NSArray<DSImagesData *> *imagesData = imageView.layout.imagesData;
    
    for (NSUInteger i = 0,max = imagesData.count; i < max ;i++) {
        DSThumbnailView *imgView = imageView.imageViews[i];
        DSImagesData *imageData = imagesData[i];
        
        DSImageScrollItem * item = [[DSImageScrollItem alloc] init];
        item.thumbView = imgView;
        item.largeImageURL = imageData.largeImage.url;
        item.largeImageSize = CGSizeMake(imageData.largeImage.width, imageData.largeImage.height);
        [items addObject:item];
        if (i == index) {
            fromView = imgView;
        }
    }
    DSImageShowView *scrollView = [[DSImageShowView alloc] initWithItems:items type:DSImageShowTypeDefault];
    //    scrollView.blurEffectBackground = YES;
    [scrollView presentfromImageView:fromView toContainer:self.navigationController.view index:index animated:YES completion:nil];
    scrollView.longPressBlock = ^(UIImageView *imageView) {
        // try to save original image data if the image contains multi-frame (such as GIF/APNG)
        id imageItem = [imageView.image yy_imageDataRepresentation];
        YYImageType type = YYImageDetectType((__bridge CFDataRef _Nonnull)(imageItem));
        if (type != YYImageTypePNG && type != YYImageTypeJPEG && type != YYImageTypeGIF) {
            imageItem = imageView;
        }
        //todo
    };
    
}

@end
