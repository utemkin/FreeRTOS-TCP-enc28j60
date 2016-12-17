#include "SEGGER_RTT.h"

int _write(int file, char *ptr, int len)
{
  SEGGER_RTT_Write(0, ptr, len);
  return len;
}
