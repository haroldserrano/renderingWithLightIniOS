//
//  ViewController.m
//  openglesinc
//
//  Created by Harold Serrano on 2/9/15.
//  Copyright (c) 2015 www.roldie.com. All rights reserved.
//

#import "ViewController.h"
#include "Character.h"

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    //1, Allocate a EAGLContext object and initialize a context with a specific version.
    self.context = [[EAGLContext alloc] initWithAPI:kEAGLRenderingAPIOpenGLES2];
    
    //2. Check if the context was successful
    if (!self.context) {
        NSLog(@"Failed to create ES context");
    }
    
    //3. Set the view's context to the newly created context
    GLKView *view = (GLKView *)self.view;
    view.context = self.context;
    view.drawableDepthFormat = GLKViewDrawableDepthFormat24;
    
    //4. This will call the rendering method glkView 60 Frames per second
    view.enableSetNeedsDisplay=60.0;
    
    //5. Make the newly created context the current context.
    [EAGLContext setCurrentContext:self.context];
    
    //6. create a Character class instance
    //Note, since the ios device will be rotated, the input parameters of the character constructor
    //are swapped.
    character=new Character(self.view.bounds.size.height,self.view.bounds.size.width);
    
    //7. Begin the OpenGL setup for the character
    character->setupOpenGL();
    
}

#pragma mark - GLKView and GLKViewController delegate methods

- (void)update
{
    character->update(self.timeSinceLastUpdate);
}

- (void)glkView:(GLKView *)view drawInRect:(CGRect)rect
{
    //1. Clear the color to black
    glClearColor(0.0f, 0.0f, 0.0f, 1.0f);
    
    //2. Clear the color buffer and depth buffer
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT);
    
    //3. Render the character
    character->draw();
}

- (void)dealloc
{
    //call teardown
    character->teadDownOpenGL();
    
    if ([EAGLContext currentContext] == self.context) {
        [EAGLContext setCurrentContext:nil];
    }
    [_context release];
    
    [super dealloc];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    
    if ([self isViewLoaded] && ([[self view] window] == nil)) {
        self.view = nil;
        
        //call teardown
        
        if ([EAGLContext currentContext] == self.context) {
            [EAGLContext setCurrentContext:nil];
        }
        self.context = nil;
    }
    
    // Dispose of any resources that can be recreated.
}



@end
