-- Waveshare CM4-Duino (https://www.waveshare.com/wiki/CM4-Duino) GPIO Test

-- Copyright (C)2024, Philip Munts dba Munts Technologies.
--
-- Redistribution and use in source and binary forms, with or without
-- modification, are permitted provided that the following conditions are met:
--
-- * Redistributions of source code must retain the above copyright notice,
--   this list of conditions and the following disclaimer.
--
-- THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS"
-- AND ANY EXPRESS OR IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE
-- IMPLIED WARRANTIES OF MERCHANTABILITY AND FITNESS FOR A PARTICULAR PURPOSE
-- ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT HOLDER OR CONTRIBUTORS BE
-- LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
-- CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF
-- SUBSTITUTE GOODS OR SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS
-- INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY, WHETHER IN
-- CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE)
-- ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE
-- POSSIBILITY OF SUCH DAMAGE.

WITH Ada.Text_IO;
USE Ada.Text_IO;

WITH Arduino.CM4_Duino;
WITH GPIO;

PROCEDURE test_cm4_duino_gpio IS

  desg : Arduino.DigitalPins;
  outp : GPIO.Pin;

BEGIN
  New_Line;
  Put_Line("CM4-Duino GPIO Toggle Test");
  New_Line;

  Put("Enter Arduino digital pin designator: ");
  Arduino.Pins_IO.Get(desg);
  New_Line;

  -- Create GPIO output object

  outp := Arduino.CM4_Duino.Create(desg, GPIO.Output);

  -- Toggle the GPIO output

  Put_Line("Press CONTROL-C to exit.");
  New_Line;

  LOOP
    outp.Put(NOT outp.Get);
  END LOOP;
END test_cm4_duino_gpio;
