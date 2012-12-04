#include "../src/../include/JSONHandler/RPC2Objects/NsRPC2Communication/UI/SetGlobalPropertiesResponse.h"
#include "../src/../include/JSONHandler/RPC2Objects/Marshaller.h"

/*
  interface	NsRPC2Communication::UI
  version	1.2
  generated at	Tue Dec  4 16:38:13 2012
  source stamp	Tue Dec  4 16:37:04 2012
  author	robok0der
*/

using namespace NsRPC2Communication::UI;


SetGlobalPropertiesResponse& SetGlobalPropertiesResponse::operator =(const SetGlobalPropertiesResponse& c)
{
  return *this;
}


SetGlobalPropertiesResponse::~SetGlobalPropertiesResponse(void)
{
}


SetGlobalPropertiesResponse::SetGlobalPropertiesResponse(void) : 
  RPC2Response(Marshaller::METHOD_NSRPC2COMMUNICATION_UI__SETGLOBALPROPERTIESRESPONSE)
{
}


SetGlobalPropertiesResponse::SetGlobalPropertiesResponse(const SetGlobalPropertiesResponse& c) : RPC2Response(Marshaller::METHOD_NSRPC2COMMUNICATION_UI__SETGLOBALPROPERTIESRESPONSE,c.getId(),c.getResult())
{
  *this=c;
}


bool SetGlobalPropertiesResponse::checkIntegrity(void)
{
  return SetGlobalPropertiesResponseMarshaller::checkIntegrity(*this);
}
