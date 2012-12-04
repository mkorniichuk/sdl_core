#ifndef NSAPPLINKRPCV2_FILETYPE_INCLUDE
#define NSAPPLINKRPCV2_FILETYPE_INCLUDE


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

///  Enumeration listing possible file types.

  class FileType
  {
  public:
    enum FileTypeInternal
    {
      INVALID_ENUM=-1,
      GRAPHIC_BMP=0,
      GRAPHIC_JPEG=1,
      GRAPHIC_PNG=2,
      AUDIO_WAVE=3,
      AUDIO_MP3=4
    };
  
    FileType() : mInternal(INVALID_ENUM)				{}
    FileType(FileTypeInternal e) : mInternal(e)		{}
  
    FileTypeInternal get(void) const	{ return mInternal; }
    void set(FileTypeInternal e)		{ mInternal=e; }
  
  private:
    FileTypeInternal mInternal;
    friend class FileTypeMarshaller;
  };
  
}

#endif
