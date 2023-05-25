/**
 * Created Date: Wednesday May 24th 2023
 * Author: DefinitelyNotAGirl@github
 * -----
 * Last Modified: Wednesday May 24th 2023 9:45:41 am
 * Modified By: DefinitelyNotAGirl@github (definitelynotagirl115169@gmail.com)
 * -----
 * Copyright (c) 2023 DefinitelyNotAGirl@github
 * 
 * Permission is hereby granted, free of charge, to any person
 * obtaining a copy of this software and associated documentation
 * files (the "Software"), to deal in the Software without
 * restriction, including without limitation the rights to use, copy,
 * modify, merge, publish, distribute, sublicense, and/or sell copies
 * of the Software, and to permit persons to whom the Software is
 * furnished to do so, subject to the following conditions:
 * 
 * The above copyright notice and this permission notice shall be
 * included in all copies or substantial portions of the Software.
 * 
 * THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
 * EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
 * MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
 * NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
 * HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
 * WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 * OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER
 * DEALINGS IN THE SOFTWARE.
 */
#include <stdint>
#include <functions>
#include <MALLOC>

#ifndef MEM_KERNEL_BOTTOM_RESERVED
    #define MEM_KERNEL_BOTTOM_RESERVED 256 //reserve first 256 memory pages by default
#endif

u64 meminit()
{
    //allocate reserved memory
    for(u64 i = 0; i < MEM_KERNEL_BOTTOM_RESERVED; i++)
    {
        if(memStatus(i*PAGE_SIZE) == MEM_STATUS_OK)
            falloc(i*PAGE_SIZE,i*PAGE_SIZE,PROC_ID_KERNEL);
    }

    return 0;
}
