//
//  MKRightImageButton.h
//  MKToolsKit
//
//  Created by xiaomk on 15/9/15.
//  Copyright (c) 2015年 mk. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MKRightImageButton : UIButton

@property (nonatomic, assign) CGFloat marginBetweenTitleAndImage; /*!< 标题与图片间的间距 */
@property (nonatomic, assign, getter=isResizeButton) BOOL resizeButton; /*!< 是否重置按钮尺寸 */

@end
