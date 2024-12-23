#include "scanner.h"

#include <stdio.h>
#include <string.h>

#include "common.h"

void initScanner(const char* source) {
  scanner.start = source;
  scanner.current = source;
  scanner.line = 1;
}

Token scanToken() {}
