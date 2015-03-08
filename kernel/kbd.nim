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

import arrayinitutil

# PC keyboard interface constants

const KBSTATP    = 0x64    # kbd controller status port(I)
const KBS_DIB    = 0x01    # kbd data in buffer
const KBDATAP    = 0x60    # kbd data port(I)

const NO         = 0

const SHIFT      = (1 shl 0)
const CTL        = (1 shl 1)
const ALT        = (1 shl 2)

const CAPSLOCK   = (1 shl 3)
const NUMLOCK    = (1 shl 4)
const SCROLLLOCK = (1 shl 5)

const E0ESC      = (1 shl 6)

# Special keycodes
const KEY_HOME   = 0xE0
const KEY_END    = 0xE1
const KEY_UP     = 0xE2
const KEY_DN     = 0xE3
const KEY_LF     = 0xE4
const KEY_RT     = 0xE5
const KEY_PGUP   = 0xE6
const KEY_PGDN   = 0xE7
const KEY_INS    = 0xE8
const KEY_DEL    = 0xE9

template C(i: int): int = 
  var c = int('@')
  i - c


#static uchar shiftcode[256] =
#{
#  [0x1D] CTL,
#  [0x2A] SHIFT,
#  [0x36] SHIFT,
#  [0x38] ALT,
#  [0x9D] CTL,
#  [0xB8] ALT
#};

declArray(shiftcode, 256, int,
  0x1D, CTL,
  0x2A, SHIFT,
  0x36, SHIFT,
  0x38, ALT,
  0x9D, CTL,
  0xB8, ALT
  )


proc kbdgetc1* () : int {.exportc.} =
#  var shift{.global.}: uint32 = 0;
  65
