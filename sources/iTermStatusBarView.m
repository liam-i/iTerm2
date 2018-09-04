//
//  iTermStatusBarView.m
//  iTerm2SharedARC
//
//  Created by George Nachman on 6/28/18.
//

#import "iTermStatusBarView.h"
#import "PTYWindow.h"

@implementation iTermStatusBarView

- (void)drawRect:(NSRect)dirtyRect {
    [super drawRect:dirtyRect];
    
    __block CGFloat x = 1;
    const CGFloat separatorTopBottomInset = 3;
    [_sections enumerateObjectsUsingBlock:^(iTermTuple<NSColor *, NSNumber *> * _Nonnull tuple, NSUInteger idx, BOOL * _Nonnull stop) {
        CGFloat offset = tuple.secondObject.doubleValue;

        if (tuple.firstObject) {
            [tuple.firstObject set];
            NSRectFill(NSMakeRect(x,
                                  1,
                                  offset - x,
                                  dirtyRect.size.height - 1));
        }

        if (self.separatorColor) {
            [self.separatorColor set];
            NSRect rect = NSMakeRect(offset, separatorTopBottomInset, 1, dirtyRect.size.height - separatorTopBottomInset * 2);
            NSRectFillUsingOperation(rect, NSCompositingOperationSourceOver);
        }

        x = offset + 1;
    }];
    
    if (self.separatorColor) {
        [self.separatorColor set];
        [[NSColor colorWithWhite:0 alpha:0.1] set];
        NSRect rect = NSMakeRect(0, 1, 1, dirtyRect.size.height - 1);
        NSRectFillUsingOperation(rect, NSCompositingOperationSourceOver);
    }
}

@end
