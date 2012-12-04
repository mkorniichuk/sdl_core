#ifndef NSAPPLINKRPCV2_VRCAPABILITIESMARSHALLER_INCLUDE
#define NSAPPLINKRPCV2_VRCAPABILITIESMARSHALLER_INCLUDE

#include <string>
#include <json/json.h>

#include "PerfectHashTable.h"

#include "../include/JSONHandler/ALRPCObjects/V2/VrCapabilities.h"


/*
  interface	Ford Sync RAPI
  version	2.0O
  date		2012-11-02
  generated at	Tue Dec  4 17:03:13 2012
  source stamp	Tue Dec  4 14:21:32 2012
  author	robok0der
*/

namespace NsAppLinkRPCV2
{

//! marshalling class for VrCapabilities

  class VrCapabilitiesMarshaller
  {
  public:
  
    static std::string toName(const VrCapabilities& e) 	{ return getName(e.mInternal) ?: ""; }
  
    static bool fromName(VrCapabilities& e,const std::string& s)
    { 
      return (e.mInternal=getIndex(s.c_str()))!=VrCapabilities::INVALID_ENUM;
    }
  
    static bool checkIntegrity(VrCapabilities& e)		{ return e.mInternal!=VrCapabilities::INVALID_ENUM; } 
    static bool checkIntegrityConst(const VrCapabilities& e)	{ return e.mInternal!=VrCapabilities::INVALID_ENUM; } 
  
    static bool fromString(const std::string& s,VrCapabilities& e);
    static const std::string toString(const VrCapabilities& e);
  
    static bool fromJSON(const Json::Value& s,VrCapabilities& e);
    static Json::Value toJSON(const VrCapabilities& e);
  
    static const char* getName(VrCapabilities::VrCapabilitiesInternal e)
    {
       return (e>=0 && e<1) ? mHashTable[e].name : NULL;
    }
  
    static const VrCapabilities::VrCapabilitiesInternal getIndex(const char* s);
  
    static const PerfectHashTable mHashTable[1];
  };
  
}

#endif
