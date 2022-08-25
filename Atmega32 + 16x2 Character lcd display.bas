'======================================================================='

' Title: LCD Display Voltmeter 5-0
' Last Updated :  03.2022
' Author : A.Hossein.Khalilian
' Program code  : BASCOM-AVR 2.0.8.5
' Hardware req. : Atmega32 + 16x2 Character lcd display

'======================================================================='

$regfile = "m32def.dat"
$crystal = 1000000

Config Lcdpin = Pin , Rs = Pind.0 , E = Pind.2 , Db4 = Pind.4 , Db5 = Pind.5 , Db6 = Pind.6 , Db7 = Pind.7
Config Lcd = 16 * 2
Cursor Off
Cls

Config Adc = Single , Prescaler = Auto , Reference = Avcc
Start Adc

Dim W As Word
Dim Input_mv As Single
Dim Input_v As Single

'-----------------------------------------------------------

Do
   Gosub Read_the_adc
   Gosub Display_lcd
   Waitms 200
Loop

End

'-----------------------------------------------------------

Read_the_adc:
   W = Getadc(7)
   Input_mv = W * 4.8828125
   Input_v = Input_mv / 1000
Return

''''''''''''''''''''''''''''''

Display_lcd:
   Locate 1 , 1 : Lcd "Input: " ; Fusing(input_v , "#.#") ; "V"
   Locate 2 , 1 : Lcd "Input: " ; Fusing(input_mv , "#.#") ; "mV"
Return

'-----------------------------------------------------------