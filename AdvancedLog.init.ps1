add-type -name Session -namespace "" -member @"
[DllImport("gdi32.dll")]
public static extern int AddFontResource(string filePath);

[DllImport("user32.dll")]
public static extern int SendMessage(int hWnd, uint Msg, int wParam, int lParam);

const int WM_FONTCHANGE = 0x001D;
const int HWND_BROADCAST = 0xffff;
"@

#$null = [Session]::AddFontResource("$PSScriptRoot\Monofur for Powerline.ttf")
#$null = [Session]::SendMessage([Session]::HWND_BROADCAST, [Session]::WM_FONTCHANGE, 0, 0);