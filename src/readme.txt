
R I C H    E D D I E
______________________________________________________________________

F U N C T I O N S
WYSYWIG editing
Loads and saves RTF files
Basic editing tools
Mouse support
Indentation 
Undo / Redo
Drag & Drop
Find - simple
Zooming
Utilities and tools


C H A N G E S
Added fix to RichEdit.pbi
 - Fixed resize issues
 - Fixed load and save RTF issues
Larger toolbar. new 24x24 icons 
Added new menues  
- tools
- help
- about


T H I N G S  T O  D O 
- Fix Text file loading and saving 
- get underline woeking
- Better Search and Replace
- maybe load image option
- maybe, lots of things

N O T E S
__________________________________________________________________________________

; Library:         RichEdit.pbi
; 
; Author:          Thomas (ts-soft) Schulz
; Co-Author:       Michael (neotoma) Taupitz
; Offcut:          Stolen from: freak, danilo, srod, andreas and others
;                  from PB-Forums and CodeArchiv
; Date:            September 04, 2015
; Version:         2.4
; Target Compiler: PureBasic 6.1
; Target OS:       Windows
; License:         Free, unrestricted, no warranty whatsoever



Function supported by 
- Redo(), GetText()
- insertflag for  (), LoadText()
- better Unicode-Support for LoadText(), SaveText()
- GetSelText(), FindText()
- SetAlignment()
- SetLeftMargin(), SetRightMargin()
- GetFont(), GetFontSize(), GetFontStyle()
- SelectAll(), Unselect(), Indent(), Outdent()
- ClearBackColor(), DisableRedraw(), IsTextSelected()
- GetZoom(), SetZoom(), CountWords(), GetRTFText()
- GetTextBackColor(), SetTextBackColor(), ClearTextBackColor()
- ScrollToLine(), GetParagraphAlign(), GetLineSpacing()
- SetLineSpacing.(), IsModified(), SetModified(), IsLink()
- GetWordUnderCursor(), GetCurrentWord()
- Replace(), ReplaceAll(), SetBulleted(), GetLineCount()  
- IsSuperscript(), SetSuperscript(), IsSubscript()
- SetSubscript(),ChangeFontSize(), LimitText()
- HideSelection(),SetUnderlineWave(),ClearUnderlineWave()
- Redraw(), GetTextLength(), GetTextColor()
- IsSmallCaps(), SetSmallCaps(),IsAllCaps(), SetAllCaps()
- CanPaste(), GetCursorPosition(), GetWordAtPosition()
- GetFirstVisibleLineNumber(), GetFirstVisibleLinePos()
- GetLastVisibleLineNumber(), GetLastVisibleLinePos()
- GetLastVisibleLineText(), GetCharPosOfPreviousWord()
- GetCharPosOfNextWord(), EmptyUndoBuffer()
- GetFirstCharPosOnLine(), GetLineLength()
- IsALignLeft(), IsAlignCenter(), IsAlignRight() 
- IsAlignJustify(),GetWordUnderCursorStart(), GetWordUnderCursorEnd()
- GetScrollPosX(), GetScrollPosY(),SetScrollPos(), SetLink()
- SetUndoLimit()
- AppendText()
- SetInterface() for ImageSupport
- SetImage()
- SetHidden(), IsHidden(), SetTextEx()
