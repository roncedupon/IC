#include "stdio.h"
#include <stdint.h>
#include <string.h>
#define AAA(base_addr) "1234 base_addr" /*this is a common*/  \
"a1243"//反斜杠之间不能有注释
#define BBB(base_addr) "1234 "#base_addr""

int main(){
    printf("AAA is %s\n",AAA(1234));
    printf("BBB is %s\n",BBB(4567));
    return 0;
}