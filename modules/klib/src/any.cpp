/**
 * Created Date: Sunday May 21st 2023
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

#include <any>
#include <bits>
#include <math>
#include <SCONV>

namespace klib
{
    any::any(u64 x) 
        :unsignedInt(x),typeId(anyTypeId::UINT64){}
    
    any::any(u32 x)
        :unsignedInt(x),typeId(anyTypeId::UINT32){}

    any::any(u16 x)
        :unsignedInt(x),typeId(anyTypeId::UINT16){}
    
    any::any(u8 x)
        :unsignedInt(x),typeId(anyTypeId::UINT8){}

    any::any(i64 x)
        :signedInt(x),typeId(anyTypeId::INT64){}

    any::any(i32 x)
        :signedInt(x),typeId(anyTypeId::INT32){}

    any::any(i16 x)
        :signedInt(x),typeId(anyTypeId::INT16){}
    
    any::any(i8 x)
        :signedInt(x),typeId(anyTypeId::INT8){}

    any::any(f32 x)
        :floatingPoint(x),typeId(anyTypeId::FLOAT32){}

    any::any(f64 x)
        :floatingPoint(x),typeId(anyTypeId::FLOAT64){}

    any::any(bool b)
        :u64(b),typeId(anyTypeId::BOOLEAN){}

    any::any(string s)
        :stringValue(s),typeId(anyTypeId::STRING){}


    //
    //misc
    //
    anyTypeId any::getType() const
    {
        return this->typeId;
    }

    //
    // u64
    //
    any::operator u64() const
    {
        if(KLIB_ANY_ISUINT(this->typeId))
            return this->unsignedInt;

        if(KLIB_ANY_ISSINT(this->typeId))
        {
            //clear most significant bit (sign bit)
            u64 ret = this->signedInt;
            CLEARBIT_63(ret);
            return ret;
        }

        if(this->typeId == anyTypeId::BOOLEAN)
        {
            if(this->boolValue)
                return 1;
            else
                return 0;
        }

        if(this->typeId == anyTypeId::FLOAT32 || this->typeId == anyTypeId::FLOAT64)
        {
            return floor(this->floatingPoint);
        }

        if(this->typeId == anyTypeId::STRING)
        {
            return u64(this->stringValue);
        }
    }

    //
    // u32
    //
    any::operator u32() const
    {
        if(KLIB_ANY_ISUINT(this->typeId))
            return this->unsignedInt;
        
        if(KLIB_ANY_ISSINT(this->typeId))
        {
            //clear most significant bit (sign bit)
            u64 ret = this->signedInt;
            CLEARBIT_63(ret);
            return ret;
        }

        if(this->typeId == anyTypeId::BOOLEAN)
        {
            if(this->boolValue)
                return 1;
            else
                return 0;
        }

        if(this->typeId == anyTypeId::FLOAT32 || this->typeId == anyTypeId::FLOAT64)
        {
            return floor(this->floatingPoint);
        }

        if(this->typeId == anyTypeId::STRING)
        {
            return u32(this->stringValue);
        }
    }

    //
    // u16
    //
    any::operator u16() const
    {
        if(KLIB_ANY_ISUINT(this->typeId))
            return this->unsignedInt;
        
        if(KLIB_ANY_ISSINT(this->typeId))
        {
            //clear most significant bit (sign bit)
            u64 ret = this->signedInt;
            CLEARBIT_63(ret);
            return ret;
        }

        if(this->typeId == anyTypeId::BOOLEAN)
        {
            if(this->boolValue)
                return 1;
            else
                return 0;
        }

        if(this->typeId == anyTypeId::FLOAT32 || this->typeId == anyTypeId::FLOAT64)
        {
            return floor(this->floatingPoint);
        }

        if(this->typeId == anyTypeId::STRING)
        {
            return u16(this->stringValue);
        }
    }

    //
    // u8
    //
    any::operator u8() const
    {
        if(KLIB_ANY_ISUINT(this->typeId))
            return this->unsignedInt;
        
        if(KLIB_ANY_ISSINT(this->typeId))
        {
            //clear most significant bit (sign bit)
            u64 ret = this->signedInt;
            CLEARBIT_63(ret);
            return ret;
        }

        if(this->typeId == anyTypeId::BOOLEAN)
        {
            if(this->boolValue)
                return 1;
            else
                return 0;
        }

        if(this->typeId == anyTypeId::FLOAT32 || this->typeId == anyTypeId::FLOAT64)
        {
            return floor(this->floatingPoint);
        }

        if(this->typeId == anyTypeId::STRING)
        {
            return u8(this->stringValue);
        }
    }

    //
    // i64
    //
    any::operator i64() const
    {
        if(KLIB_ANY_ISUINT(this->typeId))
        {
            //clear most significant bit
            i64 ret = this->unsignedInt;
            CLEARBIT_63(ret);
            return ret;
        }

        if(KLIB_ANY_ISSINT(this->typeId))
            return this->signedInt;

        if(this->typeId == anyTypeId::BOOLEAN)
        {
            if(this->boolValue)
                return 1;
            else
                return 0;
        }

        if(this->typeId == anyTypeId::FLOAT32 || this->typeId == anyTypeId::FLOAT64)
        {
            return floor(this->floatingPoint);
        }

        if(this->typeId == anyTypeId::STRING)
        {
            return i64(this->stringValue);
        }
    }

    //
    // i32
    //
    any::operator i32() const
    {
        if(KLIB_ANY_ISUINT(this->typeId))
        {
            //clear most significant bit
            i64 ret = this->unsignedInt;
            CLEARBIT_63(ret);
            return ret;
        }

        if(KLIB_ANY_ISSINT(this->typeId))
            return this->signedInt;

        if(this->typeId == anyTypeId::BOOLEAN)
        {
            if(this->boolValue)
                return 1;
            else
                return 0;
        }

        if(this->typeId == anyTypeId::FLOAT32 || this->typeId == anyTypeId::FLOAT64)
        {
            return floor(this->floatingPoint);
        }

        if(this->typeId == anyTypeId::STRING)
        {
            return i32(this->stringValue);
        }
    }

    //
    // i16
    //
    any::operator i16() const
    {
        if(KLIB_ANY_ISUINT(this->typeId))
        {
            //clear most significant bit
            i64 ret = this->unsignedInt;
            CLEARBIT_63(ret);
            return ret;
        }

        if(KLIB_ANY_ISSINT(this->typeId))
            return this->signedInt;

        if(this->typeId == anyTypeId::BOOLEAN)
        {
            if(this->boolValue)
                return 1;
            else
                return 0;
        }

        if(this->typeId == anyTypeId::FLOAT32 || this->typeId == anyTypeId::FLOAT64)
        {
            return floor(this->floatingPoint);
        }

        if(this->typeId == anyTypeId::STRING)
        {
            return i16(this->stringValue);
        }
    }

    //
    // i8
    //
    any::operator i8() const
    {
        if(KLIB_ANY_ISUINT(this->typeId))
        {
            //clear most significant bit
            i8 ret = this->unsignedInt;
            CLEARBIT_63(ret);
            return ret;
        }

        if(KLIB_ANY_ISSINT(this->typeId))
            return this->signedInt;

        if(this->typeId == anyTypeId::BOOLEAN)
        {
            if(this->boolValue)
                return 1;
            else
                return 0;
        }

        if(this->typeId == anyTypeId::FLOAT32 || this->typeId == anyTypeId::FLOAT64)
        {
            return floor(this->floatingPoint);
        }

        if(this->typeId == anyTypeId::STRING)
        {
            return i8(this->stringValue);
        }
    }

    //
    // float32
    //
    any::operator f32() const
    {
        if(KLIB_ANY_ISUINT(this->typeId))
            return f32(this->unsignedInt);

        if(KLIB_ANY_ISSINT(this->typeId))
            return f32(this->signedInt);

        if(KLIB_ANY_ISFLOAT(this->typeId))
            return this->floatingPoint;

        if(this->typeId == anyTypeId::BOOLEAN)
            return this->boolValue? 1.0f : 0.0f;

        if(this->typeId == anyTypeId::STRING)
            return f32(this->stringValue);
    }

    //
    // float64
    //
    any::operator f64() const
    {
        if(KLIB_ANY_ISUINT(this->typeId))
            return f64(this->unsignedInt);

        if(KLIB_ANY_ISSINT(this->typeId))
            return f64(this->signedInt);

        if(KLIB_ANY_ISFLOAT(this->typeId))
            return this->floatingPoint;

        if(this->typeId == anyTypeId::BOOLEAN)
            return this->boolValue? 1.0f : 0.0f;

        if(this->typeId == anyTypeId::STRING)
            return f64(this->stringValue);
    }

    any::operator string() const
    {
        if(KLIB_ANY_ISUINT(this->typeId))
            return string(this->unsignedInt);

        if(KLIB_ANY_ISFLOAT(this->typeId))
            return string(this->floatingPoint);

        if(KLIB_ANY_ISSINT(this->typeId))
            return string(this->signedInt);

        if(this->typeId == anyTypeId::BOOLEAN)
            return this->boolValue? "true" : "false";

        if(this->typeId == anyTypeId::STRING)
            return this->stringValue;

        
    }
}