/**
 * Created Date: Sunday April 16th 2023
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
#include <misc>
#include <string>

namespace klib
{
    void string::replace(string target, string replacement)
    {
        list<string> pieces = this->split(target);
        this->clear();
        for(string I : pieces)
        {
            for(char II : I)
                *this << II;
            for(char II : replacement)
                *this << II;
        }
    }

    void string::split(string delimiter,u64 limit = 0)
    {
        u64 dPOS = 0;

        list<string> result;
        string working;

        for(char I : *this)
        {
            if(I != delimiter[dPOS])
                working << I;
            else
                dPOS++;
            if(dPOS == delimiter.size())
            {
                result << working;
                working.clear();
                dPOS = 0;
            }
        }
        if(working.size() > 0)
            result << working;

        return result;
    }

    string::string(const char* str)
    {
        if(this->size != 0)
            this->clear();
        for(u64 I = 0;I<strlen(str))
            *this << str[I];
    }
}