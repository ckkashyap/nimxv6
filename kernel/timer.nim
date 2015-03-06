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

import x86asm, traps

const IO_TIMER1 = 0x040           # 8253 Timer #1

# Frequency of all three count-down timers;
# (TIMER_FREQ/freq) is the appropriate count
# to generate a frequency of freq Hz.

const TIMER_FREQ = 1193182

template TIMER_DIV(x: int) : int =
  int((((TIMER_FREQ + ( x / 2))  / x)))

const TIMER_MODE    = (IO_TIMER1 + 3) # timer mode port
const TIMER_SEL0    = 0x00            # select counter 0
const TIMER_RATEGEN = 0x04            # mode 2, rate generator
const TIMER_16BIT   = 0x30            # r/w counter 16 bits, LSB first

proc picenable(irq: int) {.importc: "picenable".}


proc timerinit() {.exportc.} = 
  # Interrupt 100 times/sec.
  outb(TIMER_MODE, TIMER_SEL0 or TIMER_RATEGEN or TIMER_16BIT)
  outb(IO_TIMER1, uint8(TIMER_DIV(100) mod 256))
  outb(IO_TIMER1, uint8(TIMER_DIV(100) / 256))
  picenable(IRQ_TIMER)

