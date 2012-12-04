#include "../include/JSONHandler/ALRPCObjects/V2/Choice.h"
#include "ChoiceMarshaller.h"
#include "ImageMarshaller.h"
/*
  interface	Ford Sync RAPI
  version	2.0O
  date		2012-11-02
  generated at	Tue Dec  4 17:03:13 2012
  source stamp	Tue Dec  4 14:21:32 2012
  author	robok0der
*/



using namespace NsAppLinkRPCV2;

Choice::Choice(const Choice& c)
{
  *this=c;
}


bool Choice::checkIntegrity(void)
{
  return ChoiceMarshaller::checkIntegrity(*this);
}


Choice::Choice(void)
{
}



bool Choice::set_choiceID(unsigned int choiceID_)
{
  if(choiceID_>65535)  return false;
  choiceID=choiceID_;
  return true;
}

bool Choice::set_image(const Image& image_)
{
  if(!ImageMarshaller::checkIntegrityConst(image_))   return false;
  image=image_;
  return true;
}

bool Choice::set_menuName(const std::string& menuName_)
{
  if(menuName_.length()>500)  return false;
  menuName=menuName_;
  return true;
}

bool Choice::set_vrCommands(const std::vector<std::string>& vrCommands_)
{
  unsigned int i=vrCommands_.size();
  if(i>100 || i<1)  return false;
  while(i--)
  {
    if(vrCommands_[i].length()>99)  return false;
  }
  vrCommands=vrCommands_;
  return true;
}




unsigned int Choice::get_choiceID(void) const
{
  return choiceID;
}


const Image& Choice::get_image(void) const 
{
  return image;
}


const std::string& Choice::get_menuName(void) const 
{
  return menuName;
}


const std::vector<std::string>& Choice::get_vrCommands(void) const 
{
  return vrCommands;
}


