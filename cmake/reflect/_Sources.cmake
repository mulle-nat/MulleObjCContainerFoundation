# This file will be regenerated by `mulle-match-to-cmake` via
# `mulle-sde reflect` and any edits will be lost.
#
# This file will be included by cmake/share/sources.cmake
#
if( MULLE_TRACE_INCLUDE)
   MESSAGE( STATUS "# Include \"${CMAKE_CURRENT_LIST_FILE}\"" )
endif()

#
# contents selected with patternfile ??-source--sources
#
set( SOURCES
src/MulleObjCContainerObjectCallback.m
src/NSArray/_MulleObjCArrayEnumerator.m
src/NSArray/_MulleObjCConcreteArray.m
src/NSArray/_MulleObjCEmptyArray.m
src/NSArray/NSArray+NSCoder.m
src/NSArray/_NSArrayPlaceholder.m
src/NSArray/NSArray.m
src/NSArray/NSEnumerator+NSArray.m
src/NSArray/NSMutableArray+NSSet.m
src/NSArray/NSMutableArray.m
src/NSArray/mulle-qsort-pointers.c
src/NSDictionary/_MulleObjCConcreteDictionary.m
src/NSDictionary/_MulleObjCConcreteMutableDictionary.m
src/NSDictionary/_MulleObjCDictionary.m
src/NSDictionary/_MulleObjCEmptyDictionary.m
src/NSDictionary/NSDictionary+NSArray.m
src/NSDictionary/NSDictionary+NSCoder.m
src/NSDictionary/_NSDictionaryPlaceholder.m
src/NSDictionary/NSDictionary.m
src/NSDictionary/NSMutableDictionary+NSArray.m
src/NSDictionary/_NSMutableDictionaryPlaceholder.m
src/NSDictionary/NSMutableDictionary.m
src/NSDictionary/NSThread+NSMutableDictionary.m
src/NSDictionary/ns-map-table.m
src/NSEnumerator.m
src/NSSet/_MulleObjCConcreteMutableSet.m
src/NSSet/_MulleObjCConcreteSet.m
src/NSSet/_MulleObjCEmptySet.m
src/NSSet/_MulleObjCSet.m
src/NSSet/NSMutableSet+NSArray.m
src/NSSet/_NSMutableSetPlaceholder.m
src/NSSet/NSMutableSet.m
src/NSSet/NSSet+NSArray.m
src/NSSet/NSSet+NSCoder.m
src/NSSet/_NSSetPlaceholder.m
src/NSSet/NSSet.m
src/NSSet/ns-hash-table.m
)

#
# contents selected with patternfile ??-source--stage2-sources
#
set( STAGE2_SOURCES
src/MulleObjCLoader+MulleObjCContainerFoundation.m
)
