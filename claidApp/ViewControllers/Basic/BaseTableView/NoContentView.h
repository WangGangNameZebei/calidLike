//
//  NoContentView.h
//  iDeliver
//
//  Created by wanggang on 2017/3/27.
//  Copyright © 2017年 zebei. All rights reserved.
//

//========== 无内容占位图 ==========//

#import <UIKit/UIKit.h>

// 无数据占位图的类型
typedef NS_ENUM(NSInteger, NoContentType) {
    /** 加载失败 */
    NoContentTypeNetwork = 0,
    /** 无数据 */
    NoContentTypeOrder   = 1
};


@interface NoContentView : UIView

/** 无数据占位图的类型 */
@property (nonatomic,assign) NSInteger type;


@end
