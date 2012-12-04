#ifndef NSAPPLINKRPCV2_GPSDATAMARSHALLER_INCLUDE
#define NSAPPLINKRPCV2_GPSDATAMARSHALLER_INCLUDE

#include <string>
#include <json/json.h>

#include "../include/JSONHandler/ALRPCObjects/V2/GPSData.h"


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

  struct GPSDataMarshaller
  {
    static bool checkIntegrity(GPSData& e);
    static bool checkIntegrityConst(const GPSData& e);
  
    static bool fromString(const std::string& s,GPSData& e);
    static const std::string toString(const GPSData& e);
  
    static bool fromJSON(const Json::Value& s,GPSData& e);
    static Json::Value toJSON(const GPSData& e);
  };
}

#endif
