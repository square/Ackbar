//
//  Catch.h
//  AckbarTesting
//
//  Created by Brian Partridge on 2/7/16.
//  Copyright © 2016 Square, Inc. All rights reserved.
//

#import <Foundation/Foundation.h>


/// Executes the given block catching and returning any thrown exceptions.
/// If no exception is thrown nil is returned.
NSException *_Nullable ackbar_catchException(__nonnull dispatch_block_t block);
