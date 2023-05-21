/**
 * Created Date: Thursday May 18th 2023
 * Author: DefinitelyNotAGirl@github
 * -----
 * Last Modified: Sunday May 21st 2023 6:37:06 am
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
#pragma once

#include <STI>
#include <exception>
namespace klib
{
    //helper functions
    static u64 hexToUint64(string& str)
    {
        u64 result = 0;
        const char* str = str.dataAddress()+2;

        for(char c : str)
        {
            if(c>0x60)
                c-=0x57;
            else if(c>0x40)
                c-=0x37;
            else
                c-=0x30;

            result <<= 4;
            result |= c;
        }
        return result;
    }

    static u64 decToUint64(string& str)
    {
        u64 result = 0;
        u64 mult = 1;
        for(char I : str)
        {
            result+=((I-0x30)*mult);
            mult*=10;
        }
        return result;
    }

    static u64 binToUint64(string& str)
    {
        exception::FUNCTION_NOT_IMPLEMENTED();
    }

    //operators
    operator u64(string s)
    {
        if(((u16*)(s.dataAddress()))[0] == 'x0')
            return hexToUint64(s)
        else if(((u16*)(s.dataAddress()))[0] == 'b0')
            return binToUint64(s);
        else
            return decToUint64(s);
    };
    operator u32(string s);
    operator u16(string s);
    operator u8(string s);
};