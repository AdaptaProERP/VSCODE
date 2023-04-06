// Programa   : RUNVSCODE
// Fecha/Hora : 30/03/2023 08:09:36
// Propósito  : Ejecutar Programa desde VSCODE
// Creado Por : Juan Navas
// Llamado por:
// Aplicación :
// Tabla      :

#INCLUDE "DPXBASE.CH"

PROCE MAIN(cCodPrg)
    LOCAL cDir,oData,cCodeExe,cMemo,lCmd:=.F.
    LOCAL cHomeDir:=CURDRIVE()+":"+GETENV("HOMEPATH")
    LOCAL cRun    :=""
    LOCAL cBat    :="RUNVSCODE.BAT"
    LOCAL cBin    :=""
    LOCAL cFilePrg:=""

    DEFAULT cCodPrg:="AAA"

    oDp:lInterprete:=.T.

    CursorWait()

    cCodeExe:=cHomeDir+"\AppData\Local\Programs\Microsoft VS Code\Code.exe"
    cFilePrg:=lower(CURDRIVE()+":\"+CURDIR()+"\MYSCRIPT\"+cCodPrg+".PRG")

    ShutDownScr(cCodPrg)  

    IF !FILE(cFilePrg)
       cMemo   :=SQLGET(oDp:cDpProgra,"PRG_TEXTO","PRG_CODIGO"+GetWhere("=",cCodPrg))
       DPWRITE(cFilePrg,cMemo)
    ENDIF

    IF !FILE(cCodeExe)
       MsgMemo("Archivo "+cCodeExe+" no existe")
       RETURN .F.
    ENDIF

    IF lCmd 

      cDir:=lower(cFilePath(cCodeExe))
      cBin:=cFileName(cCodeExe)
      cRun:="@ECHO OFF"+CRLF+;
            "CD "+cDir+CRLF+;
            cBin+" "+cFilePrg

      DPWRITE(cBat,cRun)

      WAITRUN(cBat,1)

    ELSE

      WinExec(cBat,2)

    ENDIF

RETURN .T.
// EOF
