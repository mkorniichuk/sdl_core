#include "../include/JSONHandler/ALRPCObjects/V2/GetDTCs_response.h"
#include "GetDTCs_responseMarshaller.h"
#include "../include/JSONHandler/ALRPCObjects/V2/Marshaller.h"
#include "DTCMarshaller.h"
#include "ResultMarshaller.h"

#define PROTOCOL_VERSION	2


/*
  interface	Ford Sync RAPI
  version	2.0O
  date		2012-11-02
  generated at	Tue Dec  4 17:03:13 2012
  source stamp	Tue Dec  4 14:21:32 2012
  author	robok0der
*/

using namespace NsAppLinkRPCV2;
GetDTCs_response& GetDTCs_response::operator =(const GetDTCs_response& c)
{
  success= c.success;
  resultCode= c.resultCode;
  info= c.info ? new std::string(c.info[0]) : 0;
  dtcList= c.dtcList ? new std::vector<DTC>(c.dtcList[0]) : 0;

  return *this;
}


GetDTCs_response::~GetDTCs_response(void)
{
  if(info)
    delete info;
  if(dtcList)
    delete dtcList;
}


GetDTCs_response::GetDTCs_response(const GetDTCs_response& c) : NsAppLinkRPC::ALRPCMessage(c)
{
  *this=c;
}


bool GetDTCs_response::checkIntegrity(void)
{
  return GetDTCs_responseMarshaller::checkIntegrity(*this);
}


GetDTCs_response::GetDTCs_response(void) : NsAppLinkRPC::ALRPCMessage(PROTOCOL_VERSION),
      info(0),
    dtcList(0)
{
}



bool GetDTCs_response::set_success(bool success_)
{
  success=success_;
  return true;
}

bool GetDTCs_response::set_resultCode(const std::vector<Result>& resultCode_)
{
  unsigned int i=resultCode_.size();
  while(i--)
  {
    if(!ResultMarshaller::checkIntegrityConst(resultCode_[i]))   return false;
  }
  resultCode=resultCode_;
  return true;
}

bool GetDTCs_response::set_info(const std::string& info_)
{
  if(info_.length()>1000)  return false;
  delete info;
  info=0;

  info=new std::string(info_);
  return true;
}

void GetDTCs_response::reset_info(void)
{
  if(info)
    delete info;
  info=0;
}

bool GetDTCs_response::set_dtcList(const std::vector<DTC>& dtcList_)
{
  unsigned int i=dtcList_.size();
  if(i>100 || i<1)  return false;
  while(i--)
  {
    if(!DTCMarshaller::checkIntegrityConst(dtcList_[i]))   return false;
  }
  delete dtcList;
  dtcList=0;

  dtcList=new std::vector<DTC>(dtcList_);
  return true;
}

void GetDTCs_response::reset_dtcList(void)
{
  if(dtcList)
    delete dtcList;
  dtcList=0;
}




bool GetDTCs_response::get_success(void) const
{
  return success;
}

const std::vector<Result>& GetDTCs_response::get_resultCode(void) const 
{
  return resultCode;
}

const std::string* GetDTCs_response::get_info(void) const 
{
  return info;
}

const std::vector<DTC>* GetDTCs_response::get_dtcList(void) const 
{
  return dtcList;
}

