#region conda initialize
# !! Contents within this block are managed by 'conda init' !!
(& "C:\Users\TraxidusWolf\Anaconda3\Scripts\conda.exe" "shell.powershell" "hook") | Out-String | Invoke-Expression
#endregion


#
# Este perfil/script se ejecuta cada vez que se inicia una consola PS.
# corresponde a la variable $profile.AllUsersAllHosts y sera leido antes de $profile
#

# Configurar shortcuts tipo emacs.
#Set-PSReadlineOption -EditMode Emacs

# Define keyboard shortcuts
Set-PSReadlineKeyHandler -Key Ctrl+d -Function DeleteCharOrExit  # exit terminal if line empty
Set-PSReadlineKeyHandler -Key Ctrl+Shift+c -Function CancelLine  # interrupt key
Set-PSReadlineKeyHandler -Key Ctrl+LeftArrow -Function BackwardWord  # jump words left
Set-PSReadlineKeyHandler -Key Ctrl+RightArrow -Function ForwardWord  # jump words right
Set-PSReadlineKeyHandler -Key Ctrl+w -Function BackwardKillWord  # Delete last word
Set-PSReadlineKeyHandler -Key Alt+d -Function KillWord  # Delete next word
Set-PSReadlineKeyHandler -Key Ctrl+Backspace -Function BackwardDeleteLine  # Delete line before cursor
Set-PSReadlineKeyHandler -Key Alt+Delete -Function DeleteToEnd  # Delete line after cursor

# possible functions...
#"Abort,AcceptAndGetNext,AcceptLine,AddLine,BackwardChar,BackwardDeleteChar,BackwardDeleteLine,BackwardDeleteWord,BackwardKillLine,BackwardKillWord,BackwardWord,BeginningOfHistory,BeginningOfLine,CancelLine,CaptureScreen,CharacterSearch,CharacterSearchBackward,ClearHistory,ClearScreen,Complete,Copy,CopyOrCancelLine,Cut,DeleteChar,DeleteCharOrExit,DeleteEndOfWord,DeleteLine,DeleteLineToFirstChar,DeleteToEnd,DeleteWord,DigitArgument,EndOfHistory,EndOfLine,ExchangePointAndMark,ForwardChar,ForwardDeleteLine,ForwardSearchHistory,ForwardWord,GotoBrace,GotoColumn,GotoFirstNonBlankOfLine,HistorySearchBackward,HistorySearchForward,InsertLineAbove,InsertLineBelow,InvertCase,InvokePrompt,KillLine,KillRegion,KillWord,MenuComplete,MoveToEndOfLine,NextHistory,NextLine,NextWord,NextWordEnd,Paste,PasteAfter,PasteBefore,PossibleCompletions,PrependAndAccept,PreviousHistory,PreviousLine,Redo,RepeatLastCharSearch,RepeatLastCharSearchBackwards,RepeatLastCommand,RepeatSearch,RepeatSearchBackward,ReverseSearchHistory,RevertLine,ScrllDisplayDown,ScrollDisplayDownLine,ScrollDisplayToCursor,ScrollDisplayTop,ScrollDisplayUp,ScrollDisplayUpLine,SearchChar,SearchCharBackward,SearchCharBackwardWithBackoff,SearchCharWithBackoff,SearchForward,SelectAll,SelectBackwardChar,SelectBackwardsLine,SelectBackwardWord,SelectForwardChar,SelectForwardWord,SelectLine,SelectNextWord,SelectShellBackwardWord,SelectShellForwardWord,SelectShellNextWord,SelfInsert,SetMark,ShellBackwardKillWord,ShellBackwardWord,ShellForwardWord,ShellKillWord,ShellNextWord,ShowKeyBindings,SwapCharacters,TabCompleteNext,TabCompletePrevious,Undo,UndoAll,UnixWordRubout,ValidateAndAcceptLine,ViAcceptLine,ViAcceptLineOrExit,ViAppendLine,ViBackwardDeleteGlob,ViBackwardGlob,ViBackwardWord,ViCommandMode,ViDeleteBrace,ViDeleteEndOfGlob,ViDeleteGlob,ViDeleteToBeforeChar,ViDeleteToBeforeCharBackward,ViDeleteToChar,ViDeleteToCharBackward,ViDigitArgumentInChord,ViEditVisually,ViEndOfGlob,ViEndOfPreviousGlob,ViExit,ViGotoBrace,ViInsertAtBegining,ViInsertAtEnd,ViInsertLine,ViInsertMode,ViInsertithAppend,ViInsertWithDelete,ViJoinLines,ViNextGlob,ViNextWord,ViReplaceLine,ViReplaceToBeforeChar,ViReplaceToBeforeCharBackward,ViReplaceToChar,ViReplaceToCharBackward,ViSearchHistoryBackward,ViTabCompleteNext,ViTabCompletePrevious,ViYankBeginningOfLine,ViYankEndOfGlob,ViYankEndOfWord,ViYankLeft,ViYankLine,ViYankNextGlob,ViYankNextWord,ViYankPercent,ViYankPreviousGlob,ViYankPreviousWord,ViYankRight,ViYankToEndOfLine,ViYankToFirstChar,WhatIsKey,Yank,YankLastArg,YankNthArg,YankPop"

#
# Functions
#

# Overwriter default prompt
function global:prompt {  # Multiple Write-Host commands with color
    $Splitter = $pwd -Split "\\"
    $DiskName = ($Splitter[0] -split ":")[0]

    if ($Splitter.length -gt 4){
        $PromptPath = $DiskName + "\...\" + ($Splitter[-3..-1] -join "\")
    } else {
        $PromptPath = $pwd
    }

    Write-Host($env:UserName) -nonewline -foregroundcolor Green
    Write-Host("@") -nonewline
    Write-Host($PromptPath) -nonewline -foregroundcolor DarkCyan
    return " $ "
}

# Starts a new powershell console as administrator.
Function Open-Elevated-Console {
    Start-Process powershell -Verb runas
}

#
# ALIASES
#

set-alias -name gh -value get-help
set-alias -name sudo -value Open-Elevated-Console



# Chocolatey profile
$ChocolateyProfile = "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"
if (Test-Path($ChocolateyProfile)) {
  Import-Module "$ChocolateyProfile"
}
