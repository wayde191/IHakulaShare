//
//  XibView.h
//  IHakulaShare
//
//  Created by Wayde Sun on 1/31/15.
//  Copyright (c) 2015 IHakula. All rights reserved.
//

#import <UIKit/UIKit.h>

#define APPWINDOW       [[UIApplication sharedApplication].delegate window]
#define SHIELD_ALPHA    0.3

@interface BaseXibView : UIView

+ (id)loadFromXib;

- (UIView*)viewForView:(UIView *)view;

@end
