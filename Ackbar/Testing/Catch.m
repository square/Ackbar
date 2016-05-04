//
//  Catch.m
//  AckbarTesting
//
//  Created by Brian Partridge on 2/7/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

#import "Catch.h"


NSException *_Nullable ackbar_catchException(__nonnull dispatch_block_t block)
{
    @try {
        block();
    } @catch (NSException *exception) {
        return exception;
    }
    return nil;
}
