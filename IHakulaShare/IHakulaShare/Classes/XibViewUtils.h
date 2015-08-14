//
//  XibView.h
//  IHakulaShare
//
//  Created by Wayde Sun on 1/31/15.
//  Copyright (c) 2015 IHakula. All rights reserved.

#import <UIKit/UIKit.h>

@interface XibViewUtils : NSObject

+ (id)loadViewFromXibNamed:(NSString*)xibName withFileOwner:(id)fileOwner;

//  the view must not have any connecting to the file owner
+ (id)loadViewFromXibNamed:(NSString*)xibName;
@end
