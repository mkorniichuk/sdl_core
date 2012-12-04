#ifndef NSAPPLINKRPCV2_SCROLLABLEMESSAGE_REQUESTMARSHALLER_INCLUDE
#define NSAPPLINKRPCV2_SCROLLABLEMESSAGE_REQUESTMARSHALLER_INCLUDE

#include <string>
#include <json/json.h>

#include "../include/JSONHandler/ALRPCObjects/V2/ScrollableMessage_request.h"


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

  struct ScrollableMessage_requestMarshaller
  {
    static bool checkIntegrity(ScrollableMessage_request& e);
    static bool checkIntegrityConst(const ScrollableMessage_request& e);
  
    static bool fromString(const std::string& s,ScrollableMessage_request& e);
    static const std::string toString(const ScrollableMessage_request& e);
  
    static bool fromJSON(const Json::Value& s,ScrollableMessage_request& e);
    static Json::Value toJSON(const ScrollableMessage_request& e);
  };
}

#endif
