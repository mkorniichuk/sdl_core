#ifndef NSAPPLINKRPCV2_PARAMETERPERMISSIONSMARSHALLER_INCLUDE
#define NSAPPLINKRPCV2_PARAMETERPERMISSIONSMARSHALLER_INCLUDE

#include <string>
#include <json/json.h>

#include "../include/JSONHandler/ALRPCObjects/V2/ParameterPermissions.h"


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

  struct ParameterPermissionsMarshaller
  {
    static bool checkIntegrity(ParameterPermissions& e);
    static bool checkIntegrityConst(const ParameterPermissions& e);
  
    static bool fromString(const std::string& s,ParameterPermissions& e);
    static const std::string toString(const ParameterPermissions& e);
  
    static bool fromJSON(const Json::Value& s,ParameterPermissions& e);
    static Json::Value toJSON(const ParameterPermissions& e);
  };
}

#endif
