;   If OpenConsole()
;     EnableGraphicalConsole(1)
;     ConsoleLocate(7, 8)
;     PrintN("Press return to exit")
;     Input()
;   EndIf
Structure vec2
  x.i
  y.i
  rot.i
  fig.i
EndStructure

#TR_HEIGHT = 24
#TR_WIDTH = 7

Enumeration
  #TR_LINE
  #TR_BOX
  #TR_TRIG
  #TR_ZIG
  #TR_L
EndEnumeration

Global do_exit
Global Dim cnvs(#TR_WIDTH, #TR_HEIGHT)
Global fpos.vec2
Global speed = 300
Global score
fpos\fig = #TR_BOX

Procedure draw()
  ConsoleLocate(0, 0)
  For i = 0 To #TR_HEIGHT
    For j = 0 To #TR_WIDTH
      If cnvs(j, i)
        Print(" []")
      Else
        Print("   ")
      EndIf
    Next
    PrintN("|")
  Next
  ConsoleLocate((#TR_WIDTH+2)*3, 3)
  PrintN("SCORE"+Str(score))
EndProcedure

Procedure createNfig(*pos.vec2)
  *pos\y = 0
;   *pos\x + 2
;   *pos\x = *pos\x % 6
  *pos\x = Random(5)
  *pos\rot = 0
  Select Random(4)
    Case 0
      *pos\fig = #TR_BOX
    Case 1
      *pos\fig = #TR_L
    Case 2
      *pos\fig = #TR_LINE
    Case 3
      *pos\fig = #TR_TRIG
  EndSelect
EndProcedure

Procedure drawBox(*pos.vec2)
  If *pos\x > #TR_WIDTH-1
    *pos\x = #TR_WIDTH-1
  EndIf
  ConsoleLocate(*pos\x*3, *pos\y)
  Print(" [] []")
  ConsoleLocate(*pos\x*3, *pos\y+1)
  Print(" [] []")
  If *pos\y = #TR_HEIGHT-1 Or cnvs(*pos\x, *pos\y+2) Or cnvs(*pos\x+1, *pos\y+2) 
    ConsoleLocate(*pos\x*3, *pos\y+2)
    Print("------")
    cnvs(*pos\x, *pos\y) = 1
    cnvs(*pos\x + 1, *pos\y) = 1
    cnvs(*pos\x, *pos\y + 1) = 1
    cnvs(*pos\x + 1, *pos\y + 1) = 1
    createNfig(*pos)
  EndIf
EndProcedure

Procedure drawL(*pos.vec2)
  Select *pos\rot
    Case 0
      If *pos\x > #TR_WIDTH-1
        *pos\x = #TR_WIDTH-1
      EndIf
      ConsoleLocate(*pos\x*3, *pos\y)
      Print(" [] []")
      ConsoleLocate(*pos\x*3, *pos\y+1)
      Print("    []")
      ConsoleLocate(*pos\x*3, *pos\y+2)
      Print("    []")
      If *pos\y = #TR_HEIGHT-2 Or cnvs(*pos\x, *pos\y+1) Or cnvs(*pos\x+1, *pos\y+3) 
        ConsoleLocate(*pos\x*3, *pos\y+1)
        Print("---")
        ConsoleLocate((*pos\x+1)*3, *pos\y+3)
        Print("---")
        cnvs(*pos\x, *pos\y) = 1
        cnvs(*pos\x + 1, *pos\y) = 1
        cnvs(*pos\x + 1, *pos\y + 1) = 1
        cnvs(*pos\x + 1, *pos\y + 2) = 1
        createNfig(*pos)
        ProcedureReturn
      EndIf
    Case 1
      If *pos\x > #TR_WIDTH-2
        *pos\x = #TR_WIDTH-2
      EndIf
      ConsoleLocate(*pos\x*3, *pos\y)
      Print("       []")
      ConsoleLocate(*pos\x*3, *pos\y+1)
      Print(" [] [] []")
      If *pos\y = #TR_HEIGHT-1 Or cnvs(*pos\x, *pos\y+2) Or cnvs(*pos\x + 1, *pos\y+2)  Or cnvs(*pos\x + 2, *pos\y+2)
        ConsoleLocate(*pos\x*3, *pos\y+2)
        Print("---")
        cnvs(*pos\x + 2, *pos\y) = 1
        cnvs(*pos\x + 0, *pos\y + 1) = 1
        cnvs(*pos\x + 1, *pos\y + 1) = 1
        cnvs(*pos\x + 2, *pos\y + 1) = 1
        createNfig(*pos)
        ProcedureReturn
      EndIf
    Case 2
      If *pos\x > #TR_WIDTH-1
        *pos\x = #TR_WIDTH-1
      EndIf
      ConsoleLocate(*pos\x*3, *pos\y)
      Print(" []   ")
      ConsoleLocate(*pos\x*3, *pos\y+1)
      Print(" []   ")
      ConsoleLocate(*pos\x*3, *pos\y+2)
      Print(" [] []")
      If *pos\y = #TR_HEIGHT-2 Or cnvs(*pos\x, *pos\y+3) Or cnvs(*pos\x+1, *pos\y+3) 
        ConsoleLocate((*pos\x)*3, *pos\y+3)
        Print("------")
        cnvs(*pos\x, *pos\y + 0) = 1
        cnvs(*pos\x, *pos\y + 1) = 1
        cnvs(*pos\x, *pos\y + 2) = 1
        cnvs(*pos\x + 1, *pos\y + 2) = 1
        createNfig(*pos)
        ProcedureReturn
      EndIf
    Case 3
      If *pos\x > #TR_WIDTH-2
        *pos\x = #TR_WIDTH-2
      EndIf
      ConsoleLocate(*pos\x*3, *pos\y)
      Print(" [] [] []")
      ConsoleLocate(*pos\x*3, *pos\y+1)
      Print(" []      ")
      If *pos\y = #TR_HEIGHT-1 Or cnvs(*pos\x, *pos\y+2) Or cnvs(*pos\x + 1, *pos\y+1)  Or cnvs(*pos\x + 2, *pos\y+1)
        ConsoleLocate(*pos\x*3, *pos\y+2)
        Print("---")
        cnvs(*pos\x + 0, *pos\y + 0) = 1
        cnvs(*pos\x + 1, *pos\y + 0) = 1
        cnvs(*pos\x + 2, *pos\y + 0) = 1
        cnvs(*pos\x + 0, *pos\y + 1) = 1
        createNfig(*pos)
        ProcedureReturn
      EndIf
  EndSelect
EndProcedure

Procedure drawTrig(*pos.vec2)
  Select *pos\rot
    Case 0
      If *pos\x > #TR_WIDTH-1
        *pos\x = #TR_WIDTH-1
      EndIf
      ConsoleLocate(*pos\x*3, *pos\y)
      Print("    []")
      ConsoleLocate(*pos\x*3, *pos\y+1)
      Print(" [] []")
      ConsoleLocate(*pos\x*3, *pos\y+2)
      Print("    []")
      If *pos\y = #TR_HEIGHT-2 Or cnvs(*pos\x, *pos\y+2) Or cnvs(*pos\x+1, *pos\y+3) 
        ConsoleLocate(*pos\x*3, *pos\y+1)
        Print("---")
        ConsoleLocate((*pos\x+1)*3, *pos\y+3)
        Print("---")
        cnvs(*pos\x + 0, *pos\y + 1) = 1
        cnvs(*pos\x + 1, *pos\y + 0) = 1
        cnvs(*pos\x + 1, *pos\y + 1) = 1
        cnvs(*pos\x + 1, *pos\y + 2) = 1
        createNfig(*pos)
        ProcedureReturn
      EndIf
    Case 1
      If *pos\x > #TR_WIDTH-2
        *pos\x = #TR_WIDTH-2
      EndIf
      ConsoleLocate(*pos\x*3, *pos\y)
      Print("    []   ")
      ConsoleLocate(*pos\x*3, *pos\y+1)
      Print(" [] [] []")
      If *pos\y = #TR_HEIGHT-1 Or cnvs(*pos\x, *pos\y+2) Or cnvs(*pos\x + 1, *pos\y+2)  Or cnvs(*pos\x + 2, *pos\y+2)
        ConsoleLocate(*pos\x*3, *pos\y+2)
        Print("---")
        cnvs(*pos\x + 1, *pos\y) = 1
        cnvs(*pos\x + 0, *pos\y + 1) = 1
        cnvs(*pos\x + 1, *pos\y + 1) = 1
        cnvs(*pos\x + 2, *pos\y + 1) = 1
        createNfig(*pos)
        ProcedureReturn
      EndIf
    Case 2
      If *pos\x > #TR_WIDTH-1
        *pos\x = #TR_WIDTH-1
      EndIf
      ConsoleLocate(*pos\x*3, *pos\y)
      Print(" []   ")
      ConsoleLocate(*pos\x*3, *pos\y+1)
      Print(" [] []")
      ConsoleLocate(*pos\x*3, *pos\y+2)
      Print(" []   ")
      If *pos\y = #TR_HEIGHT-2 Or cnvs(*pos\x, *pos\y+3) Or cnvs(*pos\x+1, *pos\y+2) 
        ConsoleLocate((*pos\x)*3, *pos\y+3)
        Print("------")
        cnvs(*pos\x, *pos\y + 0) = 1
        cnvs(*pos\x, *pos\y + 1) = 1
        cnvs(*pos\x, *pos\y + 2) = 1
        cnvs(*pos\x + 1, *pos\y + 1) = 1
        createNfig(*pos)
        ProcedureReturn
      EndIf
    Case 3
      If *pos\x > #TR_WIDTH-2
        *pos\x = #TR_WIDTH-2
      EndIf
      ConsoleLocate(*pos\x*3, *pos\y)
      Print(" [] [] []")
      ConsoleLocate(*pos\x*3, *pos\y+1)
      Print("    []   ")
      If *pos\y = #TR_HEIGHT-1 Or cnvs(*pos\x, *pos\y+1) Or cnvs(*pos\x + 1, *pos\y+2)  Or cnvs(*pos\x + 2, *pos\y+1)
        ConsoleLocate(*pos\x*3, *pos\y+2)
        Print("---")
        cnvs(*pos\x + 0, *pos\y + 0) = 1
        cnvs(*pos\x + 1, *pos\y + 0) = 1
        cnvs(*pos\x + 2, *pos\y + 0) = 1
        cnvs(*pos\x + 1, *pos\y + 1) = 1
        createNfig(*pos)
        ProcedureReturn
      EndIf
  EndSelect
EndProcedure

Procedure drawLine(*pos.vec2)
  Select *pos\rot
    Case 0, 2
      If *pos\x > #TR_WIDTH
        *pos\x = #TR_WIDTH
      EndIf
      ConsoleLocate(*pos\x*3, *pos\y)
      Print(" []")
      ConsoleLocate(*pos\x*3, *pos\y+1)
      Print(" []")
      ConsoleLocate(*pos\x*3, *pos\y+2)
      Print(" []")
      ConsoleLocate(*pos\x*3, *pos\y+3)
      Print(" []")
      If *pos\y = #TR_HEIGHT-3 Or cnvs(*pos\x, *pos\y+4)
        ConsoleLocate((*pos\x+1)*3, *pos\y+4)
        Print("---")
        cnvs(*pos\x, *pos\y + 0) = 1
        cnvs(*pos\x, *pos\y + 1) = 1
        cnvs(*pos\x, *pos\y + 2) = 1
        cnvs(*pos\x, *pos\y + 3) = 1
        createNfig(*pos)
        ProcedureReturn
      EndIf
    Case 1, 3
      If *pos\x > #TR_WIDTH-3
        *pos\x = #TR_WIDTH-3
      EndIf
      ConsoleLocate(*pos\x*3, *pos\y)
      Print(" [] [] [] []")
      If *pos\y = #TR_HEIGHT Or cnvs(*pos\x+0, *pos\y+1) Or cnvs(*pos\x+1, *pos\y+1) Or cnvs(*pos\x+2, *pos\y+1) Or cnvs(*pos\x+3, *pos\y+1)
        ConsoleLocate(*pos\x*3, *pos\y+2)
        Print("---")
        cnvs(*pos\x + 0, *pos\y) = 1
        cnvs(*pos\x + 1, *pos\y) = 1
        cnvs(*pos\x + 2, *pos\y) = 1
        cnvs(*pos\x + 3, *pos\y) = 1
        createNfig(*pos)
        ProcedureReturn
      EndIf
  EndSelect
EndProcedure

Procedure drawfig(*pos.vec2)
  ;   For y = 0 To 16
  ;     For x = 0 To 6
  Select *pos\fig
    Case #TR_BOX
      drawBox(*pos)
      ; ConsoleLocate(pos\x, pos\y+1)
    Case #TR_L
      drawL(*pos)
    Case #TR_LINE
      drawLine(*pos)
    Case #TR_TRIG
      drawTrig(*pos)
    Case #TR_ZIG
      
  EndSelect
  ;     Next
  ;   Next
EndProcedure

Procedure cnvsupd()
  For i = #TR_HEIGHT To 0 Step -1
    clear = 0
    For j = 0 To #TR_WIDTH
      If cnvs(j, i) And i+1 <= #TR_HEIGHT And cnvs(j, i+1) = 0 
        cnvs(j, i+1) = 1
        cnvs(j, i) = 0
      EndIf
      clear + cnvs(j, i)
    Next
    If clear = #TR_WIDTH+1
      For j = 0 To #TR_WIDTH
        cnvs(j, i) = 0
      Next
    EndIf
  Next
EndProcedure

Procedure cnvsupd2()
  cscore = 0
  For i = #TR_HEIGHT To 0 Step -1
    clear = 0
    For j = 0 To #TR_WIDTH
      clear + cnvs(j, i)
    Next
    If clear = #TR_WIDTH+1
      For j = 0 To 6
        cnvs(j, i) = 0
      Next
      For y = i To 1 Step -1
        For x = 0 To #TR_WIDTH
          cnvs(x, y) = cnvs(x, y-1)
        Next
      Next
      cscore + 1
      i + 1 
    EndIf
  Next
  score = score + (10*cscore+10)*cscore/2
EndProcedure

Procedure mov()
  Inkey()
  Select RawKey()
    Case 37
      If fpos\x > 0
        fpos\x  - 1
      EndIf
      ; left
    Case 38
      ; up
    Case 39
      ; right
      If fpos\x < #TR_WIDTH
        fpos\x + 1
      EndIf
    Case 40
      ; down
;       If fpos\y < #TR_HEIGHT-3
;         fpos\y + 1
;       EndIf
      speed = 30
    Case 82
;       rotate
      fpos\rot = (fpos\rot + 1) % 4
  EndSelect
  If RawKey() <> 0
    draw()
    drawfig(@fpos)
  EndIf
EndProcedure


For i = 0 To 16
  For j = 0 To 6
    If Random(100) > 80
      ;       cnvs(j, i) = 1
    EndIf
  Next
Next


OpenConsole()
EnableGraphicalConsole(1)
ms = ElapsedMilliseconds()
fms = ElapsedMilliseconds()
Repeat
;   draw()
;   drawfig(@fpos)
;   Delay(speed)
;   speed = 300
;   mov()
;   cnvsupd2()
  
  mov()
  If ElapsedMilliseconds() - ms > speed
    draw()
    drawfig(@fpos)
    ;     Delay(speed)
    ms = ElapsedMilliseconds()
    speed = 300
    cnvsupd2()
    fpos\y+1
  EndIf
  Delay(3)
  ;   cnvsupd()
  ;   fpos\y + 1
Until do_exit
Input()


