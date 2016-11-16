/* Automatically generated by
	SmartSyntaxPluginCodeGenerator VMMaker.oscog-nice.1982 uuid: ed988fdd-7019-41f8-9051-e08afa837953
   from
	FileCopyPlugin VMMaker.oscog-nice.1982 uuid: ed988fdd-7019-41f8-9051-e08afa837953
 */
static char __buildInfo[] = "FileCopyPlugin VMMaker.oscog-nice.1982 uuid: ed988fdd-7019-41f8-9051-e08afa837953 " __DATE__ ;



#include <math.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

/* Default EXPORT macro that does nothing (see comment in sq.h): */
#define EXPORT(returnType) returnType

/* Do not include the entire sq.h file but just those parts needed. */
#include "sqConfig.h"			/* Configuration options */
#include "sqVirtualMachine.h"	/*  The virtual machine proxy definition */
#include "sqPlatformSpecific.h"	/* Platform specific definitions */

#define true 1
#define false 0
#define null 0  /* using 'null' because nil is predefined in Think C */
#ifdef SQUEAK_BUILTIN_PLUGIN
# undef EXPORT
# define EXPORT(returnType) static returnType
#endif

#include "sqMemoryAccess.h"


/*** Function Prototypes ***/
EXPORT(const char*) getModuleName(void);
EXPORT(sqInt) primitiveFileCopyNamedTo(void);
EXPORT(sqInt) setInterpreter(struct VirtualMachine*anInterpreter);
static sqInt sqAssert(sqInt aBool);


/*** Variables ***/

#if !defined(SQUEAK_BUILTIN_PLUGIN)
static sqInt (*failed)(void);
static void * (*firstIndexableField)(sqInt oop);
static sqInt (*isBytes)(sqInt oop);
static sqInt (*pop)(sqInt nItems);
static sqInt (*primitiveFail)(void);
static sqInt (*slotSizeOf)(sqInt oop);
static sqInt (*stackValue)(sqInt offset);
static sqInt (*success)(sqInt aBoolean);
#else /* !defined(SQUEAK_BUILTIN_PLUGIN) */
extern sqInt failed(void);
extern void * firstIndexableField(sqInt oop);
extern sqInt isBytes(sqInt oop);
extern sqInt pop(sqInt nItems);
extern sqInt primitiveFail(void);
extern sqInt slotSizeOf(sqInt oop);
extern sqInt stackValue(sqInt offset);
extern sqInt success(sqInt aBoolean);
extern
#endif
struct VirtualMachine* interpreterProxy;
static const char *moduleName =
#ifdef SQUEAK_BUILTIN_PLUGIN
	"FileCopyPlugin VMMaker.oscog-nice.1982 (i)"
#else
	"FileCopyPlugin VMMaker.oscog-nice.1982 (e)"
#endif
;



/*	Note: This is hardcoded so it can be run from Squeak.
	The module name is used for validating a module *after*
	it is loaded to check if it does really contain the module
	we're thinking it contains. This is important! */

	/* InterpreterPlugin>>#getModuleName */
EXPORT(const char*)
getModuleName(void)
{
	return moduleName;
}

	/* FileCopyPlugin>>#primitiveFile:copyTo: */
EXPORT(sqInt)
primitiveFileCopyNamedTo(void)
{
	char *dstName;
	sqInt dstSz;
	sqInt ok;
	char *srcName;
	sqInt srcSz;

	success(isBytes(stackValue(1)));
	srcName = ((char *) (firstIndexableField(stackValue(1))));
	success(isBytes(stackValue(0)));
	dstName = ((char *) (firstIndexableField(stackValue(0))));
	if (failed()) {
		return null;
	}
	srcSz = slotSizeOf(((sqInt)(sqIntptr_t)(srcName) - BaseHeaderSize));
	dstSz = slotSizeOf(((sqInt)(sqIntptr_t)(dstName) - BaseHeaderSize));
	ok = sqCopyFilesizetosize(srcName, srcSz, dstName, dstSz);
	if (!ok) {
		primitiveFail();
	}
	if (failed()) {
		return null;
	}
	pop(2);
	return null;
}


/*	Note: This is coded so that it can be run in Squeak. */

	/* InterpreterPlugin>>#setInterpreter: */
EXPORT(sqInt)
setInterpreter(struct VirtualMachine*anInterpreter)
{
	sqInt ok;

	interpreterProxy = anInterpreter;
	ok = ((interpreterProxy->majorVersion()) == (VM_PROXY_MAJOR))
	 && ((interpreterProxy->minorVersion()) >= (VM_PROXY_MINOR));
	if (ok) {
		
#if !defined(SQUEAK_BUILTIN_PLUGIN)
		failed = interpreterProxy->failed;
		firstIndexableField = interpreterProxy->firstIndexableField;
		isBytes = interpreterProxy->isBytes;
		pop = interpreterProxy->pop;
		primitiveFail = interpreterProxy->primitiveFail;
		slotSizeOf = interpreterProxy->slotSizeOf;
		stackValue = interpreterProxy->stackValue;
		success = interpreterProxy->success;
#endif /* !defined(SQUEAK_BUILTIN_PLUGIN) */
	}
	return ok;
}

	/* SmartSyntaxInterpreterPlugin>>#sqAssert: */
static sqInt
sqAssert(sqInt aBool)
{
	/* missing DebugCode */;
	return aBool;
}


#ifdef SQUEAK_BUILTIN_PLUGIN

static char _m[] = "FileCopyPlugin";
void* FileCopyPlugin_exports[][3] = {
	{(void*)_m, "getModuleName", (void*)getModuleName},
	{(void*)_m, "primitiveFileCopyNamedTo\000\377", (void*)primitiveFileCopyNamedTo},
	{(void*)_m, "setInterpreter", (void*)setInterpreter},
	{NULL, NULL, NULL}
};

#else /* ifdef SQ_BUILTIN_PLUGIN */


#endif /* ifdef SQ_BUILTIN_PLUGIN */
