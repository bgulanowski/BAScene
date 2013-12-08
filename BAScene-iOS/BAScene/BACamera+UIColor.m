//
//  BACamera+UIColor.m
//  BAScene-iOS
//
//  Created by Brent Gulanowski on 12/8/2013.
//  Copyright (c) 2013 Marketcircle Inc. All rights reserved.
//

#import <BAScene/BACamera+UIColor.h>

#import <BAScene/BASceneUtilities.h>

@implementation BACamera (UIColor)

-(UIColor *)uibgColor {
	return [UIColor colorWithBAColorf:bgColor];
}

- (void)setUibgColor:(UIColor *)uibgColor {
	self.bgColor = [uibgColor BAColorf];
}

- (UIColor *)uilColor {
	return [UIColor colorWithBAColorf:lightColor];
}

- (void)setUilColor:(UIColor *)uilColor {
	self.lightColor = [uilColor BAColorf];
}

- (UIColor *)uilShine {
	return [UIColor colorWithBAColorf:lightShine];
}

- (void)setUilShine:(UIColor *)uilShine {
	self.lightShine = [uilShine BAColorf];
}

@end
