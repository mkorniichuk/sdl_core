#ifndef NSAPPLINKRPC_UNSUBSCRIBEBUTTON_RESPONSE_INCLUDE
#define NSAPPLINKRPC_UNSUBSCRIBEBUTTON_RESPONSE_INCLUDE

#include <string>

#include "Result.h"
#include "JSONHandler/ALRPCResponse.h"


/*
  interface	Ford Sync RAPI
  version	1.2
  date		2011-05-17
  generated at	Tue Dec  4 16:02:39 2012
  source stamp	Tue Dec  4 14:21:32 2012
  author	robok0der
*/

namespace NsAppLinkRPC
{

  class UnsubscribeButton_response : public ALRPCResponse
  {
  public:
  
    UnsubscribeButton_response(const UnsubscribeButton_response& c);
    UnsubscribeButton_response(void);
    
    virtual ~UnsubscribeButton_response(void);
  
    UnsubscribeButton_response& operator =(const UnsubscribeButton_response&);
  
    bool checkIntegrity(void);

    bool get_success(void) const;
    const Result& get_resultCode(void) const;
    const std::string* get_info(void) const;

    bool set_success(bool success_);
    bool set_resultCode(const Result& resultCode_);
    void reset_info(void);
    bool set_info(const std::string& info_);

  private:
  
    friend class UnsubscribeButton_responseMarshaller;


/**
     true, if successful
     false, if failed
*/
      bool success;

///  See Result
      Result resultCode;

///  Provides additional human readable info regarding the result.
      std::string* info;	//!< (1000)
  };

}

#endif
