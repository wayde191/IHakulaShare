//
//  SegmentView.m
//  MonkeyKing
//
//  Created by Wayde Sun on 12/18/14.
//  Copyright (c) 2014 MK. All rights reserved.
//

#import "ShareView.h"

#define MYBUNDLE_NAME @ "Resource.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]
#define ImageNamed2(_pointer) [UIImage imageNamed:_pointer]

#import <ShareSDK/ShareSDK.h>
#import <AGCommon/UIDevice+Common.h>
#import "WXApi.h"
#import "WeiboSDK.h"
#import <TencentOpenAPI/QQApi.h>

#define ScreenBoundHeight [UIScreen mainScreen].bounds.size.height
#define ScreenBoundWidth  [UIScreen mainScreen].bounds.size.width

@implementation ShareView

- (NSString*)getMyBundlePath:(NSString *)filename
{
    NSBundle * libBundle = MYBUNDLE ;
    if ( libBundle && filename ){
        NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
        return s;
    }
    return nil ;
}

- (void)awakeFromNib {
    
    [_sliderBGView addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(hide)]];
    _name = @"test name";
    _shareUrl = @"http://www.baidu.com";
}


- (void)show {
    if (ScreenBoundWidth == 320) {
        //遍历view约束，找到属于scrollview的约束
        NSArray* constrains = self.bottomView.constraints;
        for (NSLayoutConstraint* constraint in constrains) {
            if (constraint.firstItem == self.wechatView) {
                //据底部
                if (constraint.secondAttribute == NSLayoutAttributeLeading) {
                    constraint.constant = 17;
                    [self.wechatView layoutIfNeeded];
                }
            }
        }
    }
    
    [UIView animateWithDuration:.3 animations:^{
        CGFloat y = ScreenBoundHeight - self.frame.size.height;
        
        CGRect frame = self.frame;
        frame.origin.y = y;
        self.frame = frame;
        
    } completion:^(BOOL finished) {
        
    }];
}

- (void)hide {
    [UIView animateWithDuration:.3 animations:^{
        CGFloat y = ScreenBoundHeight;
        
        CGRect frame = self.frame;
        frame.origin.y = y;
        self.frame = frame;
        
    }completion:^(BOOL finished) {
        if (self.shareResultHandler) {
            self.shareResultHandler(ShareTypeOther, SSResponseStateCancel);
        }
    }];
}

- (IBAction)onSinaBtnClicked:(id)sender {
    UIButton *button = sender;
    button.tag = 4;
    [self buttonClicked:button];
}

- (IBAction)onQzoneBtnClicked:(id)sender {
    UIButton *button = sender;
    button.tag = 3;
    [self buttonClicked:button];
}

- (IBAction)onWechatFriendBtnClicked:(id)sender {
    UIButton *button = sender;
    button.tag = 2;
    [self buttonClicked:button];
}

- (IBAction)onWechatBtnClicked:(id)sender {
    UIButton *button = sender;
    button.tag = 1;
    [self buttonClicked:button];
}

- (IBAction)onCancelBtnClicked:(id)sender {
    [self hide];
}

- (void)buttonClicked:(id)sender
{
    /**
     * 分享
     *
    UIButton *button = (UIButton*)sender;
    ShareType shareType;
    if (1 == button.tag) {
        shareType = ShareTypeWeixiSession;
        [self handleWXsession];
    } else if (2 == button.tag) {
        shareType = ShareTypeWeixiTimeline;
        [self handlewxTimeLine];
    } else if (3 == button.tag) {
        shareType = ShareTypeQQSpace;
        [self handleqqZone];
    } else if (4 == button.tag) {
        shareType = ShareTypeSinaWeibo;
        [self handlesinaWeibo];
    }
     */

    
    
    UIButton *button = (UIButton*)sender;
    ShareType shareType = ShareTypeAny;
    if (1 == button.tag) {
        shareType = ShareTypeWeixiSession;
    } else if (2 == button.tag) {
        shareType = ShareTypeWeixiTimeline;
    } else if (3 == button.tag) {
        shareType = ShareTypeQQSpace;
    } else if (4 == button.tag) {
        shareType = ShareTypeSinaWeibo;
        if (![WeiboSDK isWeiboAppInstalled]) {
            [self hide];
        }
    }
    
    id<ISSContent> publishContent = nil;
    [_shareContentDic objectForKey:@"contentString"];
    [_shareContentDic objectForKey:@"titleString"];
    [_shareContentDic objectForKey:@"urlString"];
    [_shareContentDic objectForKey:@"description"];
    
    NSString *contentString = @"www.xunlu.com";
    NSString *titleString   = @"xunlu";
    NSString *urlString     = @"www.xunlu.com";
    NSString *description   = @"Testing";
    
    //TODO: 4. 正确选择分享内容的 mediaType 以及填写参数，就能分享到微信
    publishContent = [ShareSDK content:contentString
                        defaultContent:@""
                                 image:nil
                                 title:titleString
                                   url:urlString
                           description:description
                             mediaType:SSPublishContentMediaTypeText];
    [ShareSDK clientShareContent:publishContent type:shareType statusBarTips:NO result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
        if (self.shareResultHandler) {
            self.shareResultHandler(type, state);
        }
        
        NSString *name = nil;
        switch (type)
        {
            case ShareTypeWeixiSession:
                name = NSLocalizedStringFromTable(@"ShareType_22",@"ShareSDKLocalizable",nil);
                break;
            case ShareTypeWeixiTimeline:
                name = NSLocalizedStringFromTable(@"ShareType_23",@"ShareSDKLocalizable",nil);
                break;
            case ShareTypeSinaWeibo:
                name = NSLocalizedStringFromTable(@"ShareType_1",@"ShareSDKLocalizable",nil);
                break;
            default:
                name = NSLocalizedStringFromTable(@"ShareType_24",@"ShareSDKLocalizable",nil);
                break;
        }
        
        NSString *notice = nil;
        if (state == SSPublishContentStateSuccess)
        {
            notice = [NSString stringWithFormat:NSLocalizedStringFromTable(@"MSG_SHARE_SUCCESS",@"ShareSDKLocalizable", nil), name];
            NSLog(@"%@",notice);
            
            UIAlertView *view =
            [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALTER_VIEW_TITLE", @"ShareSDKLocalizable",nil)
                                       message:notice
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedStringFromTable(@"ALTER_VIEW_I_KNOWN_BUTTON", @"ShareSDKLocalizable",nil)
                             otherButtonTitles: nil];
            [view show];
        }
        else if (state == SSPublishContentStateFail)
        {
            if (error) {
                notice = [NSString stringWithFormat:NSLocalizedStringFromTable(@"MSG_SHARE_FAIL", @"ShareSDKLocalizable",nil), name, [error errorDescription]];
            }else {
                notice = [NSString stringWithFormat:NSLocalizedStringFromTable(@"MSG_SHARE_FAIL_2", @"ShareSDKLocalizable",nil)];
            }
            
            NSLog(@"%@",notice);
            
            UIAlertView *view =
            [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALTER_VIEW_TITLE", @"ShareSDKLocalizable",nil)
                                       message:notice
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedStringFromTable(@"ALTER_VIEW_I_KNOWN_BUTTON", @"ShareSDKLocalizable",nil)
                             otherButtonTitles: nil];
            [view show];
        }else if (state == SSPublishContentStateCancel)
        {
            notice = [NSString stringWithFormat:NSLocalizedStringFromTable(@"MSG_SHARE_FAIL_2", @"ShareSDKLocalizable",nil)];
            
            UIAlertView *view =
            [[UIAlertView alloc] initWithTitle:NSLocalizedStringFromTable(@"ALTER_VIEW_TITLE", @"ShareSDKLocalizable",nil)
                                       message:notice
                                      delegate:nil
                             cancelButtonTitle:NSLocalizedStringFromTable(@"ALTER_VIEW_I_KNOWN_BUTTON", @"ShareSDKLocalizable",nil)
                             otherButtonTitles: nil];
            [view show];
        }
    }];
}

@end
