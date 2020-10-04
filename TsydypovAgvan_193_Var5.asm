format PE console

entry Start

include 'win32a.inc'

section '.data' data readable writable

        strInfo db 'Tsydypov_Agvan_193 Var 5 ', 10,13,0
        strN db 'Enter ArrayA Size : ', 0
        strIa db 'Array[',0
        strIb db ']?: ',0
        spaceStr db ', ', 0
        strX db 'Enter X: ', 0

        AStr db 'A',0
        BStr db 'B',0
        arrayStr db 'Array:', 0
        enterStr db 10,13,0
        emptyStr db '%d',0

        counter dd ?
        x dd ?
        i dd ? ;size of A array
        j dd 0 ;size of B array
        a dd ?
        A dd 99 dup(?) ;максимальный размер
        B dd 99 dup(?) ;максимальный размер


section '.code' code readable executable

        Start:  ; вступление
                invoke printf, strInfo

                invoke printf, strN

                push i
                push emptyStr
                call [scanf]

                invoke printf, strX

                push x
                push emptyStr
                call[scanf]

                mov ebx,A
                mov [counter],0

        CreateArray: ;вводим элементы массива
                push strIa
                call [printf]

                push [counter]
                push emptyStr
                call [printf]

                push strIb
                call [printf]

                push a
                push emptyStr
                call [scanf]

                mov edx, [a]
                mov [ebx], edx
                add ebx,4
                add [counter],1

                mov ecx,[counter]
                cmp ecx,[i]
                jl CreateArray

                mov ebx,A
                invoke printf, AStr
                invoke printf, arrayStr
                mov [counter], 0

        ArrayOut: ;вывод массива A
                mov ecx, [ebx]
                invoke printf, emptyStr, ecx
                add ebx,4
                inc [counter]
                mov eax, [counter]
                cmp eax,[i]
                je dontdelay
                invoke printf, spaceStr
                dontdelay:
                cmp eax,[i]
                jl ArrayOut
                invoke printf, enterStr

                mov ebx,A
                mov eax,B
                mov ecx,0

        NewArray:  ;переделываем массив A в новый массив B
                mov edx,[ebx]

                cmp edx,[x]
                jne NotEqual
                jmp EndNewArray

                NotEqual:
                mov [eax], edx
                inc [j]
                add eax,4

                EndNewArray:
                add ebx,4
                inc ecx

                cmp ecx,[i]
                jl NewArray

                mov ebx,B
                invoke printf, BStr
                invoke printf, arrayStr
                mov edx, [j]
                mov [i], edx
                mov [counter], 0

         ArrOut1: ;вывод массива B
                  mov ecx, [ebx]
                  invoke printf, emptyStr, ecx
                  add ebx,4
                  inc [counter]
                  mov eax, [counter]
                  cmp eax,[i]
                  je dontdelay1
                  invoke printf, spaceStr
                  dontdelay1:
                  cmp eax,[i]
                  jl ArrOut1
                  invoke printf, enterStr

        exit:

                call [getch]

                push 0
                call [ExitProcess]

section '.idata' import data readable  ;библиотеки

        library kernel, 'kernel32.dll',\
                msvcrt, 'msvcrt.dll'

        import kernel,\
               ExitProcess, 'ExitProcess'

        import msvcrt,\
               printf, 'printf',\
               scanf, 'scanf',\
               getch, '_getch'











