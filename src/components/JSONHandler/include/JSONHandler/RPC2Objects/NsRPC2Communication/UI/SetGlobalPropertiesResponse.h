#ifndef NSRPC2COMMUNICATION_UI_SETGLOBALPROPERTIESRESPONSE_INCLUDE
#define NSRPC2COMMUNICATION_UI_SETGLOBALPROPERTIESRESPONSE_INCLUDE

#include "JSONHandler/RPC2Response.h"


/*
  interface	NsRPC2Communication::UI
  version	1.2
  generated at	Tue Dec  4 16:38:13 2012
  source stamp	Tue Dec  4 16:37:04 2012
  author	robok0der
*/

namespace NsRPC2Communication
{
  namespace UI
  {

    class SetGlobalPropertiesResponse : public ::NsRPC2Communication::RPC2Response
    {
    public:
    
      SetGlobalPropertiesResponse(const SetGlobalPropertiesResponse& c);
      SetGlobalPropertiesResponse(void);
    
      SetGlobalPropertiesResponse& operator =(const SetGlobalPropertiesResponse&);
    
      virtual ~SetGlobalPropertiesResponse(void);
    
      bool checkIntegrity(void);
    

    private:

      friend class SetGlobalPropertiesResponseMarshaller;


    };
  }
}

#endif
