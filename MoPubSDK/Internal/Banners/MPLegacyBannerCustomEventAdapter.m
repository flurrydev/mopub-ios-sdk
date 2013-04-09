//
//  MPLegacyBannerCustomEventAdapter.m
//  MoPub
//
//  Copyright (c) 2013 MoPub. All rights reserved.
//

#import "MPLegacyBannerCustomEventAdapter.h"
#import "MPAdConfiguration.h"

@implementation MPLegacyBannerCustomEventAdapter

- (void)getAdWithConfiguration:(MPAdConfiguration *)configuration containerSize:(CGSize)size
{
    MPLogInfo(@"Looking for custom event selector named %@.", configuration.customSelectorName);

    SEL customEventSelector = NSSelectorFromString(configuration.customSelectorName);
    if ([self.delegate.bannerDelegate respondsToSelector:customEventSelector]) {
        [self.delegate.bannerDelegate performSelector:customEventSelector];
        return;
    }

    NSString *oneArgumentSelectorName = [configuration.customSelectorName
                                         stringByAppendingString:@":"];

    MPLogInfo(@"Looking for custom event selector named %@.", oneArgumentSelectorName);

    SEL customEventOneArgumentSelector = NSSelectorFromString(oneArgumentSelectorName);
    if ([self.delegate.bannerDelegate respondsToSelector:customEventOneArgumentSelector]) {
        [self.delegate.bannerDelegate performSelector:customEventOneArgumentSelector
                                           withObject:self.delegate.banner];
        return;
    }

    [self.delegate adapter:self didFailToLoadAdWithError:nil];
}

@end
