Const $text = "CHITUBOX 1.8.1 Setup"

Func Install($config)
    Local $install = $config.Item("install")
    ConsoleWrite("Install: " & $install & @LF)

    WinWaitActive($text)
	Sleep(1000)
    Send("!y")
EndFunc

ConsoleWrite("Starting" & @LF)
Local $config = ObjCreate("Scripting.Dictionary")
Install($config)
ConsoleWrite("End of Install!" & @LF)
