# The MIT License (MIT)
# 
# Copyright (c) 2015 Kashyap
# 
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the "Software"), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
# 
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
# 
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

proc strlen* (s: cstring) : int {.exportc.} =
  var count = 0
  while true:
    if int(s[count]) == 0:
      break
    count = count + 1
  return count


proc safestrcpy(o: ptr char, input: cstring, length: int) : ptr char {.exportc.} =
  var o1: cstring = cast[cstring](o)  
  for idx in 0 .. length - 1:
     o1[idx] = input[idx]
  o

proc strncpy(o: ptr char, input: cstring, length: int) : ptr char {.exportc.} =
  var o1: cstring = cast[cstring](o)
  var doCopy = true
  for idx in 0 .. length - 1:
    if doCopy:
      o1[idx] = input[idx]
    else:
      o1[idx]= char(0)
  o  

# TODO - check if this can be optimized
proc strncmp(p: cstring, q: cstring, length: int) : int {.exportc.} =
  for idx in 0 .. length - 1:
    var pc:int = int(p[idx])
    var qc:int  = int(q[idx])
    if pc != qc: return (pc - qc)
    if pc == 0: return 0
  return 0

proc memmove(dst: ptr char, src: ptr char, length: int) : ptr char {.exportc.} =
  var src1: cstring = cast[cstring](src)
  var dst1: cstring = cast[cstring](dst)
  for idx in 0 .. length - 1:
    dst1[idx] = src1[idx]
  dst

proc memcpy(dst: ptr char, src: ptr char, length: int) : ptr char {.exportc.} =
  memmove(dst, src, length)


# TODO - check if this can be optimized
proc memcmp(p: cstring, q: cstring, length: int) : int {.exportc.} =
  for idx in 0 .. length - 1:
    var pc:int = int(p[idx])
    var qc:int  = int(q[idx])
    if pc != qc: return (pc - qc)
  return 0

# TODO - types should be proper - not int32
# Also use better pointer types for faster copy
proc memset(dst: ptr char, val: int32, length: int) : ptr char {.exportc.} =
  var dst1: cstring = cast[cstring](dst)
  var byte:uint8 = uint8(val and 0xff)
  for idx in 0 .. length - 1:
    dst1[idx] = char(byte)
  dst
