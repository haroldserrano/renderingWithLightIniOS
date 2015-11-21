//
//  main.m
//  openglesinc
//
//  Created by Harold Serrano on 2/9/15.
//  Copyright (c) 2015 www.roldie.com. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "AppDelegate.h"

void gltSetWorkingDirectory(const char *szArgv);

int main(int argc, char * argv[])
{
    
    gltSetWorkingDirectory(*argv);
    
    @autoreleasepool {
        return UIApplicationMain(argc, argv, nil, NSStringFromClass([AppDelegate class]));
    }
}


void gltSetWorkingDirectory(const char *szArgv)
{
#ifdef __APPLE__
	static char szParentDirectory[255];
    
	///////////////////////////////////////////////////////////////////////////
	// Get the directory where the .exe resides
	char *c;
	strncpy( szParentDirectory, szArgv, sizeof(szParentDirectory) );
	szParentDirectory[254] = '\0'; // Make sure we are NULL terminated
	
	c = (char*) szParentDirectory;
    
	while (*c != '\0')     // go to end
        c++;
    
	while (*c != '/')      // back up to parent
        c--;
    
	*c++ = '\0';           // cut off last part (binary name)
    
	///////////////////////////////////////////////////////////////////////////
	// Change to Resources directory. Any data files need to be placed there
	chdir(szParentDirectory);
#ifndef OPENGL_ES
	chdir("../Resources");
#endif
#endif
}