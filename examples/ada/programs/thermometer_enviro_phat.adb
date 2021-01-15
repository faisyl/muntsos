-- Pimoroni Enviro pHAT Internet Thermometer Example Program

-- Copyright (C)2017-2018, Philip Munts, President, Munts AM Corp.
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

-- NOTE: The temperature reading will be significantly higher than the actual
-- ambient temperature because of heat generated by the CPU board.

WITH Ada.Calendar.Formatting;
WITH Ada.Strings.Fixed;
WITH BMP280;
WITH libLinux;
WITH Pimoroni_Enviro_pHAT;
WITH Pressure;
WITH Temperature;
WITH Watchdog.libsimpleio;
WITH Webserver.HashTable;

USE TYPE Pressure.Pascals;
USE TYPE Temperature.Celsius;

USE Pressure.Pascals_IO;
USE Temperature.Celsius_IO;

PROCEDURE thermometer_enviro_phat IS

  newline : CONSTANT String := ASCII.CR & ASCII.LF;
  refresh : CONSTANT String := "<META HTTP-EQUIV='Refresh' CONTENT=5>" &
    newline;
  title   : CONSTANT String := "<h1>Ada Internet of Things Thermometer</h1>" &
    newline & "<h2>Using the Pimoroni Enviro pHAT</h2>" & newline;

  wd      : Watchdog.Timer;
  error   : Integer;
  T       : Temperature.Celsius;
  P       : Pressure.Pascals;
  outbuf1 : String(1 .. 20);
  outbuf2 : String(1 .. 20);

BEGIN
  DELAY 5.0;

  wd := Watchdog.libsimpleio.Create;
  wd.SetTimeout(5.0);

  libLinux.Detach(error);

  Webserver.HashTable.Publish("/", title);
  Webserver.HashTable.Start;

  libLinux.DropPrivileges("nobody" & ASCII.NUL, error);

  LOOP
    T := Pimoroni_Enviro_pHAT.Baro_Temp.Get;
    P := Pimoroni_Enviro_pHAT.Baro_Temp.Get/100.0;

    Put(outbuf1, T, 1, 0);
    Put(outbuf2, P, 2, 0);

    Webserver.HashTable.Publish("/", refresh & title & "<p>" &
      Ada.Calendar.Formatting.Image(Ada.Calendar.Clock) & " UTC -- " &
      Ada.Strings.Fixed.Trim(outbuf1, Ada.Strings.Left) & " &deg;C -- " &
      Ada.Strings.Fixed.Trim(outbuf2, Ada.Strings.Left) & " hPa</p>" & newline);

    DELAY 0.3;

    wd.Kick;
  END LOOP;
END thermometer_enviro_phat;
