//
//  Created by Andrew Podkovyrin
//  Copyright © 2019 Dash Core Group. All rights reserved.
//
//  Licensed under the MIT License (the "License");
//  you may not use this file except in compliance with the License.
//  You may obtain a copy of the License at
//
//  https://opensource.org/licenses/MIT
//
//  Unless required by applicable law or agreed to in writing, software
//  distributed under the License is distributed on an "AS IS" BASIS,
//  WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
//  See the License for the specific language governing permissions and
//  limitations under the License.
//

#import "DWSeedPhraseTitledView.h"

#import "DWSeedPhraseTitledModel.h"
#import "DWSeedPhraseView.h"
#import "DevicesCompatibility.h"
#import "UIColor+DWStyle.h"
#import "UIFont+DWFont.h"

NS_ASSUME_NONNULL_BEGIN

static CGFloat TitleSeedPhrasePadding(void) {
    if (IS_IPHONE_5_OR_LESS) {
        return 12.0;
    }
    else {
        return 20.0;
    }
}

@interface DWSeedPhraseTitledView ()

@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) DWSeedPhraseView *seedPhraseView;

@end

@implementation DWSeedPhraseTitledView

- (instancetype)initWithType:(DWSeedPhraseType)type {
    self = [super initWithFrame:CGRectZero];
    if (self) {
        self.backgroundColor = [UIColor dw_secondaryBackgroundColor];

        UILabel *titleLabel = [[UILabel alloc] init];
        titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        titleLabel.backgroundColor = self.backgroundColor;
        titleLabel.textAlignment = NSTextAlignmentCenter;
        titleLabel.font = [UIFont dw_fontForTextStyle:UIFontTextStyleTitle2];
        titleLabel.textColor = [UIColor dw_darkTitleColor];
        titleLabel.adjustsFontForContentSizeCategory = YES;
        titleLabel.numberOfLines = 0;
        [self addSubview:titleLabel];
        _titleLabel = titleLabel;

        DWSeedPhraseView *seedPhraseView = [[DWSeedPhraseView alloc] initWithType:type];
        seedPhraseView.translatesAutoresizingMaskIntoConstraints = NO;
        [self addSubview:seedPhraseView];
        _seedPhraseView = seedPhraseView;

        [NSLayoutConstraint activateConstraints:@[
            [titleLabel.topAnchor constraintEqualToAnchor:self.topAnchor],
            [titleLabel.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [titleLabel.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],

            [seedPhraseView.topAnchor constraintEqualToAnchor:titleLabel.bottomAnchor
                                                     constant:TitleSeedPhrasePadding()],
            [seedPhraseView.leadingAnchor constraintEqualToAnchor:self.leadingAnchor],
            [seedPhraseView.bottomAnchor constraintEqualToAnchor:self.bottomAnchor],
            [seedPhraseView.trailingAnchor constraintEqualToAnchor:self.trailingAnchor],
        ]];
    }
    return self;
}

- (void)layoutSubviews {
    [super layoutSubviews];

    if (!CGSizeEqualToSize(self.bounds.size, [self intrinsicContentSize])) {
        [self invalidateIntrinsicContentSize];
    }
}

- (CGSize)intrinsicContentSize {
    CGFloat width = self.bounds.size.width;
    CGFloat height = self.titleLabel.intrinsicContentSize.height +
                     TitleSeedPhrasePadding() +
                     self.seedPhraseView.intrinsicContentSize.height;
    return CGSizeMake(width, height);
}

- (void)setModel:(nullable DWSeedPhraseTitledModel *)model {
    _model = model;

    self.titleLabel.text = model.subTitle;
    self.seedPhraseView.model = model.seedPhrase;
}

@end

NS_ASSUME_NONNULL_END