//
//  _MulleObjCSet.m
//  MulleObjCContainerFoundation
//
//  Copyright (c) 2016 Nat! - Mulle kybernetiK.
//  Copyright (c) 2016 Codeon GmbH.
//  All rights reserved.
//
//
//  Redistribution and use in source and binary forms, with or without
//  modification, are permitted provided that the following conditions are met:
//
//  Redistributions of source code must retain the above copyright notice, this
//  list of conditions and the following disclaimer.
//
//  Redistributions in binary form must reproduce the above copyright notice,
//  this list of conditions and the following disclaimer in the documentation
//  and/or other materials provided with the distribution.
//
//  Neither the name of Mulle kybernetiK nor the names of its contributors
//  may be used to endorse or promote products derived from this software
//  without specific prior written permission.
//
//  THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
//  AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
//  IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
//  ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
//  LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
//  CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
//  SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
//  INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
//  CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
//  ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
//  POSSIBILITY OF SUCH DAMAGE.
//
#pragma clang diagnostic ignored "-Wparentheses"

#import "_MulleObjCSet.h"

// other files in this library
#import "NSEnumerator.h"
#import "NSArray+NSEnumerator.h"

// other libraries of MulleObjCContainerFoundation

// std-c and dependencies

// private files
#import "_MulleObjCSet-Private.h"


@interface _MulleObjCSetEnumerator : NSEnumerator < NSEnumerator>
{
   _MulleObjCSet< NSObject>     *_owner;
   struct mulle__setenumerator  _rover;
}

- (instancetype) initWithSet:(_MulleObjCSet<NSObject> *) set
                  mulle__set:(struct mulle__set *) _set;

@end


@implementation _MulleObjCSetEnumerator

- (instancetype) initWithSet:(_MulleObjCSet<NSObject> *) set
                  mulle__set:(struct mulle__set *) _set
{
   _owner = [set retain];
   _rover = _mulle__set_enumerate( _set, &NSSetCallback);
   return( self);
}


- (void) dealloc

{
   mulle__setenumerator_done( &_rover);

   [_owner release];
   [super dealloc];
}


- (id) nextObject
{
   id   obj;

   if( _mulle__setenumerator_next( &_rover, (void **) &obj))
      return( obj);
   return( nil);
}

@end

#pragma clang diagnostic ignored "-Wobjc-root-class"
#pragma clang diagnostic ignored "-Wprotocol"


PROTOCOLCLASS_IMPLEMENTATION( _MulleObjCSet)


- (void) decodeWithCoder:(NSCoder *) coder
{
   NSUInteger               count;
   id                       obj;
   struct mulle_allocator   *allocator;
   _MulleObjCSetIvars       *ivars;

   ivars     = _MulleObjCSetGetIvars( self);
   allocator = MulleObjCInstanceGetAllocator( self);
   [coder decodeValueOfObjCType:@encode( NSUInteger)
                             at:&count];
   while( count)
   {
      [coder decodeValueOfObjCType:@encode( id)
                                at:&obj];
      _mulle__set_set( &ivars->_table, obj, &NSSetAssignRetainedCallback, allocator);
      --count;
   }
}


- (void) dealloc
{
   _MulleObjCSetFree( self);
}


- (NSEnumerator *) objectEnumerator
{
   _MulleObjCSetIvars   *ivars;

   ivars = _MulleObjCSetGetIvars( self);
   return( [[_MulleObjCSetEnumerator instantiate] initWithSet:(id) self
                                                   mulle__set:&ivars->_table]);
}


- (BOOL) containsObject:(id) obj
{
   _MulleObjCSetIvars   *ivars;

   ivars = _MulleObjCSetGetIvars( self);
   return( _mulle__set_get( &ivars->_table, obj, &NSSetCallback) != NULL);
}


- (id) member:(id) obj
{
   _MulleObjCSetIvars   *ivars;

   ivars = _MulleObjCSetGetIvars( self);
   return( _mulle__set_get( &ivars->_table, obj, &NSSetCallback));
}



- (id) :(id) obj
{
   _MulleObjCSetIvars   *ivars;

   ivars = _MulleObjCSetGetIvars( self);
   return( _mulle__set_get( &ivars->_table, obj, &NSSetCallback));
}


- (NSUInteger) count
{
   _MulleObjCSetIvars   *ivars;

   ivars = _MulleObjCSetGetIvars( self);
   return( _mulle__set_get_count( &ivars->_table));
}


struct _MulleObjCSetFastEnumerationState
{
   struct mulle__setenumerator   _rover;
};


- (NSUInteger) countByEnumeratingWithState:(NSFastEnumerationState *) rover
                                   objects:(id *) buffer
                                     count:(NSUInteger) len
{
   struct _MulleObjCSetFastEnumerationState   *dstate;
   id                                         obj;
   id                                         *sentinel;

   assert( sizeof( struct _MulleObjCSetFastEnumerationState) <= sizeof( long) * 5);
   assert( alignof( struct _MulleObjCSetFastEnumerationState) <= alignof( long));

   if( rover->state == -1)
      return( 0);

   // get our stat and init if its the first run
   dstate = (struct _MulleObjCSetFastEnumerationState *) rover->extra;
   if( ! rover->state)
   {
      _MulleObjCSetIvars   *ivars;

      ivars          = _MulleObjCSetGetIvars( self);
      dstate->_rover = _mulle__set_enumerate( &ivars->_table, &NSSetCallback);
      rover->state   = 1;
   }

   rover->itemsPtr  = buffer;

   sentinel = &buffer[ len];
   while( buffer < sentinel)
   {
      if( ! _mulle__setenumerator_next( &dstate->_rover, (void **) &obj))
      {
         rover->state = -1;
         break;
      }
      *buffer++ = obj;
   }

   rover->mutationsPtr = &rover->extra[ 4];

   return( len - (sentinel - buffer));
}

PROTOCOLCLASS_END()
