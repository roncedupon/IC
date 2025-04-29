#include "stdio.h"
#include <stdint.h>
int GETBIT(int data, int bit_pos){
    return (data>>bit_pos)&0x1;
}

// Note: Function name 'voird_ototalsize' might be a typo. 
// Assuming 'int' return type based on the return statement.
int volrd_ototalsize(int Read1056SeLN, int Read1056SeLS, int Read176SeLN, int Read176SeLS, int nssel){
    if (nssel==3){
        int read_lens_n=(GETBIT(Read1056SeLN,0)+GETBIT(Read1056SeLN,2))*(
            GETBIT(Read176SeLN,0)+
            GETBIT(Read176SeLN,1)+
            GETBIT(Read176SeLN,2)+
            GETBIT(Read176SeLN,3)+
            GETBIT(Read176SeLN,4)+
            GETBIT(Read176SeLN,5))*176*2+ // Calculation involving bits 0-4 + bit 5 * 352
            (GETBIT(Read1056SeLS,0)+GETBIT(Read1056SeLS,2))*( // This multiplication seems nested incorrectly, maybe parenthesis missing?
            GETBIT(Read176SeLS,0)+
            GETBIT(Read176SeLS,1)+
            GETBIT(Read176SeLS,2)+
            GETBIT(Read176SeLS,3)+
            GETBIT(Read176SeLS,4)+
            GETBIT(Read176SeLS,5))*176*2;// Calculation involving bits 0-4 + bit 5 * 352

        int read_lens_s=(GETBIT(Read1056SeLN,1)+GETBIT(Read1056SeLN,3))*(
            GETBIT(Read176SeLN,0)+
            GETBIT(Read176SeLN,1)+
            GETBIT(Read176SeLN,2)+
            GETBIT(Read176SeLN,3)+
            GETBIT(Read176SeLN,4)+
            GETBIT(Read176SeLN,5))*176*2+ // Calculation involving bits 0-4 + bit 5 * 352
            (GETBIT(Read1056SeLS,1)+GETBIT(Read1056SeLS,3))*( // This multiplication seems nested incorrectly, maybe parenthesis missing?
            GETBIT(Read176SeLS,0)+
            GETBIT(Read176SeLS,1)+
            GETBIT(Read176SeLS,2)+
            GETBIT(Read176SeLS,3)+
            GETBIT(Read176SeLS,4)+
            GETBIT(Read176SeLS,5))*176*2; // Calculation involving bits 0-4 + bit 5 * 352

        printf("[voird_ototalsize]read_lens_n is %d\n",read_lens_n);
        printf("[voird_ototalsize]read_lens_s is %d\n",read_lens_s);
        // The following calculation effectively computes ceil(read_lens_n / 128.0) + ceil(read_lens_s / 128.0) and multiplies by 128
        return ((read_lens_n >> 7) + ((read_lens_n & 0x7f) != 0) + (read_lens_s >> 7) + ((read_lens_s & 0x7f) != 0)) * 128; // align to 128B
    }
    // Missing return statement if nssel != 3
    // Consider adding a default return value or handling this case.
    // return 0; // Example default return
}
void main(){
    printf("%d\n",volrd_ototalsize(0x5,0xa,0x3f,0x3f,3)>>7);
}