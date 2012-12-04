#include "../include/JSONHandler/ALRPCObjects/V1/DeleteInteractionChoiceSet_response.h"
#include "DeleteInteractionChoiceSet_responseMarshaller.h"
#include "../include/JSONHandler/ALRPCObjects/V1/Marshaller.h"
#include "ResultMarshaller.h"

#define PROTOCOL_VERSION	1


/*
  interface	Ford Sync RAPI
  version	1.2
  date		2011-05-17
  generated at	Tue Dec  4 16:02:39 2012
  source stamp	Tue Dec  4 14:21:32 2012
  author	robok0der
*/

using namespace NsAppLinkRPC;
DeleteInteractionChoiceSet_response& DeleteInteractionChoiceSet_response::operator =(const DeleteInteractionChoiceSet_response& c)
{
  success= c.success;
  resultCode= c.resultCode;
  info= c.info ? new std::string(c.info[0]) : 0;

  return *this;}


DeleteInteractionChoiceSet_response::~DeleteInteractionChoiceSet_response(void)
{
  if(info)
    delete info;
}


DeleteInteractionChoiceSet_response::DeleteInteractionChoiceSet_response(const DeleteInteractionChoiceSet_response& c)
{
  *this=c;
}


bool DeleteInteractionChoiceSet_response::checkIntegrity(void)
{
  return DeleteInteractionChoiceSet_responseMarshaller::checkIntegrity(*this);
}


DeleteInteractionChoiceSet_response::DeleteInteractionChoiceSet_response(void) : ALRPCResponse(PROTOCOL_VERSION,Marshaller::METHOD_DELETEINTERACTIONCHOICESET_RESPONSE),
      info(0)
{
}



bool DeleteInteractionChoiceSet_response::set_success(bool success_)
{
  success=success_;
  return true;
}

bool DeleteInteractionChoiceSet_response::set_resultCode(const Result& resultCode_)
{
  if(!ResultMarshaller::checkIntegrityConst(resultCode_))   return false;
  resultCode=resultCode_;
  return true;
}

bool DeleteInteractionChoiceSet_response::set_info(const std::string& info_)
{
  if(info_.length()>1000)  return false;
  delete info;
  info=0;

  info=new std::string(info_);
  return true;
}

void DeleteInteractionChoiceSet_response::reset_info(void)
{
  if(info)
    delete info;
  info=0;
}




bool DeleteInteractionChoiceSet_response::get_success(void) const
{
  return success;
}

const Result& DeleteInteractionChoiceSet_response::get_resultCode(void) const 
{
  return resultCode;
}

const std::string* DeleteInteractionChoiceSet_response::get_info(void) const 
{
  return info;
}

