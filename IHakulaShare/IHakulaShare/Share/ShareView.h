//
//  SegmentView.h
//  MonkeyKing
//
//  Created by Wayde Sun on 12/18/14.
//  Copyright (c) 2014 MK. All rights reserved.
//

#import "BaseXibView.h"
#import <ShareSDK/ShareSDK.h>

@interface ShareView : BaseXibView {
}

typedef void (^ShareResultBlock)(ShareType type, SSResponseState state);
@property (copy, nonatomic) ShareResultBlock shareResultHandler;

@property (strong, nonatomic) NSDictionary *shareContentDic;

- (IBAction)onSinaBtnClicked:(id)sender;
- (IBAction)onQzoneBtnClicked:(id)sender;
- (IBAction)onWechatFriendBtnClicked:(id)sender;
- (IBAction)onCancelBtnClicked:(id)sender;
- (IBAction)onWechatBtnClicked:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *wechatView;
@property (weak, nonatomic) IBOutlet UIButton *sinaBtn;
@property (weak, nonatomic) IBOutlet UIButton *qzoneBtn;
@property (weak, nonatomic) IBOutlet UIButton *wechatBtn;
@property (weak, nonatomic) IBOutlet UIButton *wechatFriendBtn;
@property (weak, nonatomic) IBOutlet UIView *bottomView;
@property (weak, nonatomic) IBOutlet UIView *sliderBGView;

@property(weak, nonatomic) NSString *name;
@property(weak, nonatomic) NSString *imageUrl;
@property(weak, nonatomic) NSString *shareUrl;
- (void)show;
- (void)hide;

@end
